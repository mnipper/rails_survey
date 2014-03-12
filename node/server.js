process.title = 'realtime-app';

var sockjs  = require('sockjs');
var express = require('express');
var app = express();

var server = require('http').createServer(app);
var io = require('socket.io').listen(server);
var redis = require("redis");
server.listen(3001);

//simple logger
app.use(function(req, res, next) {
	console.log('%s %s', req.method, req.url);
	next();
});

io.sockets.on('connection', function (socket) {
	// subscribe to redis
	var subscribe = redis.createClient();
	subscribe.subscribe('responses-create');
	
	//periodic update
	setInterval(broadcast, 1000);

	// relay redis messages to connected socket
	subscribe.on("message", function(channel, message) {
		console.log("from rails to subscriber:", channel, message);
		socket.emit('message', message)
	});

	// unsubscribe from redis if session disconnects
	socket.on('disconnect', function () {
		console.log("user disconnected");
		subscribe.quit();
	});
});

//webSocket stuff
var clients = {};
var clientCount = 0;
var interval;

function broadcast() {
  var message = JSON.stringify({ count: "UPDATE" });
  var publisher = redis.createClient();
  publisher.publish('responses-create', message);
  console.log("broadcast SENT");
}

//function startBroadcast () {
//	  interval = setInterval(broadcast, 1000);
//}

var sockjsServer = sockjs.createServer();
//sockjsServer.on('connection', function(conn) {
//	clientCount++;
//	if (clientCount === 1) {
//		startBroadcast();
//	}
//	clients[conn.id] = conn;
//	conn.on('close', function() {
//		clientCount--;
//		delete clients[conn.id];
//		if (clientCount === 0) {
//			clearInterval(interval);
//		}
//	});
//});
sockjsServer.installHandlers(server, { prefix: '/sockjs' });

process.title = 'realtime-app';

var sockjs  = require('sockjs');
var express = require('express');
var app = express();
var https = require('https');
var fs = require('fs');
var options = {
	    key:    fs.readFileSync('/etc/httpd/conf/ssl.key/wci-chpir_duke_edu-private.key'),
	    cert:   fs.readFileSync('/etc/httpd/conf/ssl.crt/wci-chpir_duke_edu.cer')
	};
TODO Extract above certs
var server = https.createServer(options, app);
var server = https.createServer(app);
var io = require('socket.io').listen(server);
var redis = require("redis");
server.listen(8080);
var publisher = undefined;
var INTERVAL = 3000;

//simple logger
app.use(function(req, res, next) {
	console.log('%s %s', req.method, req.url);
	next();
});

io.sockets.on('connection', function (socket) {
	// subscribe to redis
	var subscribe = redis.createClient();
	subscribe.subscribe('responses-create');
	
	//publish and start periodic update
	publisher = redis.createClient();
	setInterval(broadcast, INTERVAL);

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

function broadcast() {
  var message = JSON.stringify({ count: 0 });
  publisher.publish('responses-create', message);
}

var sockjsServer = sockjs.createServer();
sockjsServer.installHandlers(server, { prefix: '/sockjs' });

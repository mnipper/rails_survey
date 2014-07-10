window.App = angular.module('Survey', ['ngResource', 'ui.sortable', 'localytics.directives', 'chieffancypants.loadingBar', 'ngAnimate', 'ngSanitize', 'textAngular', 'angularFileUpload', 'ngCookies', 'ui.keypress'])
.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

window.App = angular.module('Survey', ['ngResource', 'ui.sortable', 'localytics.directives', 'chieffancypants.loadingBar', 'ngAnimate', 'ngSanitize', 'textAngular', 'angularFileUpload'])
.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

window.App = angular.module('Survey', ['ngResource', 'ui.sortable', 'localytics.directives'])
.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

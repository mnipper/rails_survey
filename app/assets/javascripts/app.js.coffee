window.App = angular.module('Survey', ['ngResource', 'ui.sortable', 'localytics.directives', 'chieffancypants.loadingBar', 'ngAnimate'])
.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

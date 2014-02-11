window.App = angular.module('Survey', ['ngResource', 'ui.sortable', 'localytics.directives', 'chieffancypants.loadingBar', 'ngAnimate', 'ngSanitize', 'textAngular', 'nvd3ChartDirectives'])
.config(['$locationProvider', ($locationProvider) ->
  $locationProvider.html5Mode(true)
])

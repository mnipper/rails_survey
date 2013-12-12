App.controller 'QuestionsCtrl', ['$scope', 'Question', ($scope, Question) ->
  $scope.questions = Question.query()
]

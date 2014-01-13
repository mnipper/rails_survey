App.controller 'OptionsCtrl', ['$scope', 'Option', ($scope, Option) ->
  $scope.options = []
  $scope.init = (instrument_id, question_id) ->
    #TODO refactor into option service
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    $scope.options = Option.query({"instrument_id": instrument_id, "question_id": question_id})

  $scope.$on('SAVE_QUESTION', ->
    angular.forEach $scope.options, (option, index) ->
      #TODO refactor into option service
      option.instrument_id = $scope.instrument_id
      option.question_id = $scope.question_id
      if option.id
        option.$update()
      else
        option.$save()
  )

  $scope.$on('CANCEL_QUESTION', ->
    $scope.options = Option.query({"instrument_id": $scope.instrument_id, "question_id": $scope.question_id})
  )

  $scope.removeOption = (option) ->
    $scope.options.splice($scope.options.indexOf(option), 1)
    #TODO refactor into option service
    option.instrument_id = $scope.instrument_id
    option.question_id = $scope.question_id
    option.$delete()

  $scope.addOption = ->
    option = new Option
    #TODO refactor into option service
    option.instrument_id = $scope.instrument_id
    option.question_id = $scope.question_id
    $scope.options.push(option)
]

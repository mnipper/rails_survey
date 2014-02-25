App.directive 'ngThumb', ['$window'
  ($window) ->
    helper =
      support: !!($window.FileReader and $window.CanvasRenderingContext2D)
      isFile: (item) ->
        angular.isObject(item) and item instanceof $window.File

      isImage: (file) ->
        type = "|" + file.type.slice(file.type.lastIndexOf("/") + 1) + "|"
        "|jpg|png|jpeg|bmp|gif|".indexOf(type) isnt -1

    return (
      restrict: "A",
      template: "<canvas/>"
      
      link: (scope, element, attributes) ->
        
        onLoadFile = (event) ->
          img = new Image()
          img.onload = onLoadImage
          img.src = event.target.result
        
        onLoadImage = ->
          width = params.width or @width / @height * params.height
          height = params.height or @height / @width * params.width
          canvas.attr
            width: width
            height: height

          canvas[0].getContext("2d").drawImage this, 0, 0, width, height
        
        return  unless helper.support
        
        params = scope.$eval(attributes.ngThumb)
        return  unless helper.isFile(params.file)
        return  unless helper.isImage(params.file)
        
        canvas = element.find("canvas")
        
        reader = new FileReader()
        reader.onload = onLoadFile
        reader.readAsDataURL params.file
    )
]

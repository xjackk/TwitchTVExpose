#  tkillilea my utility functions being added to $ namespace (jQuery)
define ["jquery"], ($) ->
    #IIFE  instantly invoked Function Expression
	# display elapsed time in relative terms  // pass in a timestamp ie dispay:  5 min(s) ago

	# attach a utility function to the $ namespace
	$.wait = (time) ->
		$.Deferred((dfd) ->
			setTimeout dfd.resolve, time
		).promise()

	# attach a utility function to the $ namespace
	$.getCurrentUser = ->
		$.ajax
			type: "POST"
			contentType: "application/json; charset=utf-8"
			url: "/wsProfile.asmx/getCurrentUser"
			data: "{}"
			dataType: "json"

# togglewrapper plugin/ place an opacity wrapper over an existing element
	$.fn.toggleWrapper = (obj = {}, init = true) ->
		_.defaults obj,
			className: ""
			backgroundColor: if @css("backgroundColor") isnt "transparent" then @css("backgroundColor") else "white"
			zIndex: if @css("zIndex") is "auto" or 0 then 1000 else (Number) @css("zIndex")

		$offset = @offset()
		$width 	= @outerWidth(false)
		$height = @outerHeight(false)

		if init
			$("<div>")
				.appendTo("body")
					.addClass(obj.className)
						.attr("data-wrapper", true)
							.css
								width: $width
								height: $height 
								top: $offset.top
								left: $offset.left
								position: "absolute"
								zIndex: obj.zIndex + 1
								backgroundColor: obj.backgroundColor
		else
			$("[data-wrapper]").remove()

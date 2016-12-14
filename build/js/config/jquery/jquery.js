(function() {
  define(["jquery", "spin", "jqueryspin"], function($) {
    $.wait = function(time) {
      return $.Deferred(function(dfd) {
        return setTimeout(dfd.resolve, time);
      }).promise();
    };
    $.getCurrentUser = function() {
      return $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/wsProfile.asmx/getCurrentUser",
        data: "{}",
        dataType: "json"
      });
    };
    return $.fn.toggleWrapper = function(obj, init) {
      var $height, $offset, $width;
      if (obj == null) {
        obj = {};
      }
      if (init == null) {
        init = true;
      }
      _.defaults(obj, {
        className: "",
        backgroundColor: this.css("backgroundColor") !== "transparent" ? this.css("backgroundColor") : "white",
        zIndex: this.css("zIndex") === "auto" || 0 ? 1000 : Number(this.css("zIndex"))
      });
      $offset = this.offset();
      $width = this.outerWidth(false);
      $height = this.outerHeight(false);
      if (init) {
        return $("<div>").appendTo("body").addClass(obj.className).attr("data-wrapper", true).css({
          width: $width,
          height: $height,
          top: $offset.top,
          left: $offset.left,
          position: "absolute",
          zIndex: obj.zIndex + 1,
          backgroundColor: obj.backgroundColor
        });
      } else {
        return $("[data-wrapper]").remove();
      }
    };
  });

}).call(this);

(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['underscore', 'msgbus', 'd3'], function(_, msgBus) {
    var BubbleChart;
    return BubbleChart = (function() {
      function BubbleChart(data, el, width, height) {
        this.select_details = bind(this.select_details, this);
        this.hide_details = bind(this.hide_details, this);
        this.show_details = bind(this.show_details, this);
        this.display = bind(this.display, this);
        this.start = bind(this.start, this);
        this.create_vis = bind(this.create_vis, this);
        var max_amount, max_model;
        this.data = data;
        this.el = el;
        this.width = width;
        this.height = height;
        this.center = {
          x: this.width / 2,
          y: this.height / 2
        };
        this.layout_gravity = -0.01;
        this.damper = 0.1;
        this.vis = null;
        this.nodes = [];
        this.force = null;
        this.circles = null;
        this.fill_color = d3.scale.ordinal().domain(["low", "medium", "high"]).range(["#d84b2a", "#beccae", "#7aa25c"]);
        max_model = this.data.max(function(model) {
          return model.get("viewers");
        });
        max_amount = max_model.get("viewers");
        this.radius_scale = d3.scale.pow().exponent(0.5).domain([0, max_amount]).range([3, 100]);
        this.create_nodes();
        this.create_vis();
      }

      BubbleChart.prototype.create_nodes = function() {
        this.data.each((function(_this) {
          return function(model, i) {
            var node;
            node = {
              id: i,
              model: model,
              radius: _this.radius_scale(parseInt(model.get("viewers"))),
              value: model.get("viewers"),
              name: model.get("game").name,
              imageUrl: model.get("game").logo.medium,
              x: Math.random() * _this.width,
              y: Math.random() * _this.height,
              group: _.sample(["low", "medium", "high"])
            };
            return _this.nodes.push(node);
          };
        })(this));
        return this.nodes.sort(function(a, b) {
          return b.value - a.value;
        });
      };

      BubbleChart.prototype.create_vis = function() {
        var that;
        this.vis = d3.select(this.el).append("svg").attr("width", this.width).attr("height", this.height).attr("id", "svg_vis");
        this.circles = this.vis.selectAll("circle").data(this.nodes, function(d) {
          return d.id;
        });
        that = this;
        this.circles.enter().append("circle").attr("r", 0).attr("id", function(d) {
          return "bub" + d.id;
        }).style("fill", (function(_this) {
          return function(d) {
            return _this.fill_color(d.group);
          };
        })(this)).style("stroke-width", 2).style("stroke", (function(_this) {
          return function(d) {
            return d3.rgb(_this.fill_color(d.group)).darker();
          };
        })(this)).on("mouseover", function(d, i) {
          return that.show_details(d, i, this);
        }).on("mouseout", function(d, i) {
          return that.hide_details(d, i, this);
        }).on("click", function(d, i) {
          return that.select_details(d, i, this);
        });
        return this.circles.transition().duration(1500).attr("r", function(d) {
          return d.radius;
        });
      };

      BubbleChart.prototype.charge = function(d) {
        return -Math.pow(d.radius, 2.0) / 7;
      };

      BubbleChart.prototype.start = function() {
        return this.force = d3.layout.force().nodes(this.nodes).size([this.width, this.height]);
      };

      BubbleChart.prototype.display = function() {
        this.force.gravity(this.layout_gravity).charge(this.charge).friction(0.9).on("tick", (function(_this) {
          return function(e) {
            return _this.circles.each(_this.move_towards_center(e.alpha)).attr("cx", function(d) {
              return d.x;
            }).attr("cy", function(d) {
              return d.y;
            });
          };
        })(this));
        return this.force.start();
      };

      BubbleChart.prototype.move_towards_center = function(alpha) {
        return (function(_this) {
          return function(d) {
            d.x = d.x + (_this.center.x - d.x) * (_this.damper + 0.02) * alpha;
            return d.y = d.y + (_this.center.y - d.y) * (_this.damper + 0.02) * alpha;
          };
        })(this);
      };

      BubbleChart.prototype.show_details = function(data, i, element) {
        var bubble, options;
        d3.select(element).style("stroke", "black");
        bubble = $("#bub" + data.id);
        options = {
          html: true,
          title: data.name,
          placement: "top",
          trigger: "manual",
          container: "body",
          content: function() {
            var pop;
            return pop = "<img src=" + data.imageUrl + " class='img-responsive img-thumbnail'><br/><b>Viewers:</b><span> " + data.value + "</span><br/>";
          }
        };
        return bubble.popover(options).popover("show");
      };

      BubbleChart.prototype.hide_details = function(data, i, element) {
        d3.select(element).style("stroke", (function(_this) {
          return function(d) {
            return d3.rgb(_this.fill_color(d.group)).darker();
          };
        })(this));
        return $("#bub" + data.id).popover("hide");
      };

      BubbleChart.prototype.select_details = function(data, i, element) {
        this.hide_details(data, i, element);
        return msgBus.events.trigger("app:game:detail", data.model);
      };

      return BubbleChart;

    })();
  });

}).call(this);

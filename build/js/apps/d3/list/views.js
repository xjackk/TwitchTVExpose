(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(['apps/d3/list/templates', 'views/_base', 'd3'], function(Templates, AppView) {
    var DataVisLayout, _item;
    return {
      DataVis: _item = (function(superClass) {
        extend(_item, superClass);

        function _item() {
          this.onShow = bind(this.onShow, this);
          return _item.__super__.constructor.apply(this, arguments);
        }

        _item.prototype.template = _.template(Templates.datavis);

        _item.prototype.className = "well";

        _item.prototype.onShow = function() {
          var collide, color, force, height, nodes, root, svg, width;
          width = this.$el.outerWidth(false);
          height = Math.floor(width * 9 / 16);
          nodes = d3.range(250).map(function() {
            return {
              radius: Math.random() * 16 + 4
            };
          });
          root = nodes[0];
          color = d3.scale.category10();
          root.radius = 0;
          root.fixed = true;
          force = d3.layout.force().gravity(0.12).charge(function(d, i) {
            if (i) {
              return 0;
            } else {
              return -2500;
            }
          }).nodes(nodes).size([width, height]);
          force.start();
          svg = d3.select(this.el).append("svg").attr("width", width).attr("height", height);
          svg.selectAll("circle").data(nodes.slice(1)).enter().append("circle").attr("r", function(d) {
            return d.radius - 2;
          }).style("fill", function(d, i) {
            return color(i % 10);
          });
          force.on("tick", function(e) {
            var i, n, q;
            q = d3.geom.quadtree(nodes);
            i = 0;
            n = nodes.length;
            while (++i < n) {
              q.visit(collide(nodes[i]));
            }
            return svg.selectAll("circle").attr("cx", function(d) {
              return d.x;
            }).attr("cy", function(d) {
              return d.y;
            });
          });
          svg.on("mousemove", function() {
            var p1;
            p1 = d3.mouse(this);
            root.px = p1[0];
            root.py = p1[1];
            return force.resume();
          });
          return collide = function(node) {
            var nx1, nx2, ny1, ny2, r;
            r = node.radius + 16;
            nx1 = node.x - r;
            nx2 = node.x + r;
            ny1 = node.y - r;
            ny2 = node.y + r;
            return function(quad, x1, y1, x2, y2) {
              var l, x, y;
              if (quad.point && (quad.point !== node)) {
                x = node.x - quad.point.x;
                y = node.y - quad.point.y;
                l = Math.sqrt(x * x + y * y);
                r = node.radius + quad.point.radius;
                if (l < r) {
                  l = (l - r) / l * .5;
                  node.x -= x *= l;
                  node.y -= y *= l;
                  quad.point.x += x;
                  quad.point.y += y;
                }
              }
              return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
            };
          };
        };

        return _item;

      })(AppView.ItemView),
      Layout: DataVisLayout = (function(superClass) {
        extend(DataVisLayout, superClass);

        function DataVisLayout() {
          return DataVisLayout.__super__.constructor.apply(this, arguments);
        }

        DataVisLayout.prototype.template = _.template(Templates.layout);

        DataVisLayout.prototype.regions = {
          panelRegion: "#panel-region",
          dataVisRegion1: "#datavis-region"
        };

        return DataVisLayout;

      })(AppView.Layout)
    };
  });

}).call(this);

define ['apps/d3/list/templates', 'views/_base', 'd3'], (Templates, AppView) ->

    DataVis: class _item extends AppView.ItemView
        template: _.template(Templates.datavis)
        className: "well"

        # use D3 to render a canvas on our view
        onShow: =>
            width = @$el.outerWidth(false)
            height= Math.floor width * 9 / 16

            nodes = d3.range(250).map ->
                radius: Math.random() * 16 + 4
            root = nodes[0]
            color = d3.scale.category10()

            root.radius = 0
            root.fixed = true

            force = d3.layout.force().gravity(0.12).charge((d, i) ->
                (if i then 0 else -2500)
            ).nodes(nodes).size([width, height])

            force.start()

            svg = d3.select(@el).append("svg").attr("width", width).attr("height", height)

            svg.selectAll("circle").data(nodes.slice(1)).enter().append("circle").attr("r", (d) -> d.radius-2).style("fill", (d, i) -> color i % 5)


            force.on "tick", (e) ->
                q = d3.geom.quadtree(nodes)
                i = 0
                n = nodes.length
                q.visit collide(nodes[i]) while ++i < n
                svg.selectAll("circle").attr("cx", (d) -> d.x).attr("cy", (d) ->d.y)

            svg.on "mousemove", ->
                p1 = d3.mouse(@)
                root.px = p1[0]
                root.py = p1[1]
                force.resume()


            collide = (node) ->
                r = node.radius + 16
                nx1 = node.x - r
                nx2 = node.x + r
                ny1 = node.y - r
                ny2 = node.y + r
                return (quad, x1, y1, x2, y2) ->
                    if quad.point and (quad.point isnt node)
                        x = node.x - quad.point.x
                        y = node.y - quad.point.y
                        l = Math.sqrt(x * x + y * y)
                        r = node.radius + quad.point.radius
                        if l < r
                            l = (l - r) / l * .5
                            node.x -= x *= l
                            node.y -= y *= l
                            quad.point.x += x
                            quad.point.y += y
                    x1 > nx2 or x2 < nx1 or y1 > ny2 or y2 < ny1

    Layout: class DataVisLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            panelRegion: "#panel-region"
            dataVisRegion1: "#datavis-region"
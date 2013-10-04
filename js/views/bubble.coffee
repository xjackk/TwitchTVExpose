define ['underscore', 'msgbus', 'd3' ], (_, msgBus) ->
    class BubbleChart
        constructor: (data, el, width, height) ->
            @data = data
            @el = el
            @width = width
            @height = height
            @hittest=0

            # locations the nodes will move towards
            # depending on which view is currently being used
            @center = {x: @width / 2, y: @height / 2}

            # used when setting up force and
            # moving around nodes
            @layout_gravity = -0.01
            @damper = 0.1

            # these will be set in create_nodes and create_vis
            @vis = null
            @nodes = []
            @force = null
            @circles = null


            # nice looking colors - no reason to buck the trend
            @fill_color = d3.scale.ordinal().domain(["low", "medium", "high"]).range(["#d84b2a", "#beccae", "#7aa25c"])

            max_model = @data.max (model) ->
                model.get("viewers")

            max_amount = max_model.get "viewers"

            @radius_scale = d3.scale.pow().exponent(0.5).domain([0, max_amount]).range([3, 100])

            @create_nodes()
            @create_vis()

        # create node objects from original data
        # that will serve as the data behind each
        # bubble in the vis, then add each node
        # to @nodes to be used later
        create_nodes: ->
            @data.each (model,i) =>
                node=
                    id: i #model.get("game")._id # unique id from twitchAPI
                    model: model
                    radius: @radius_scale(parseInt(model.get "viewers"))
                    value: model.get "viewers"
                    name: model.get("game").name
                    imageUrl: model.get("game").logo.medium
                    x: Math.random() * @width
                    y: Math.random() * @height
                    group: _.sample ["low","medium","high"]
                @nodes.push node

            @nodes.sort (a,b) -> b.value - a.value

        # create svg at #vis and then create circle representation for each node
        create_vis: =>
            @vis = d3.select(@el).append("svg")
                .attr("width", @width)
                .attr("height", @height)
                .attr("id", "svg_vis")

            @circles = @vis.selectAll("circle").data(@nodes, (d)->d.id)

            that=@

            # radius will be set to 0 initially. see transition below
            @circles.enter().append("circle")
                .attr("r", 0)
                .attr("id", (d) -> "bub#{d.id}")
                .style("fill", (d) => @fill_color d.group )
                .style("stroke-width", 2)
                .style("stroke", (d) => d3.rgb(@fill_color(d.group)).darker())
                .on("mouseover", (d,i) -> that.show_details(d, i , @))
                .on("mouseout", (d,i) -> that.hide_details(d, i, @))
                .on("click", (d,i) -> that.select_details(d, i, @))

            # Fancy transition to make bubbles appear, ending with the correct radius
            @circles.transition().duration(1500).attr("r", (d) -> d.radius)

        # Charge function that is called for each node.
        # Charge is proportional to the diameter of the
        # circle (which is stored in the radius attribute
        # of the circle's associated data.
        # This is done to allow for accurate collision
        # detection with nodes of different sizes.
        # Charge is negative because we want nodes to repel.
        # Dividing by 7 scales down the charge to be
        # appropriate for the visualization dimensions.
        charge: (d) ->
            -Math.pow(d.radius, 2.0) / 7

        # Starts up the force layout with the default values
        start: =>
            @force = d3.layout.force().nodes(@nodes).size([@width, @height])

        # Sets up force layout to display all nodes in one circle.
        display: =>
            @force.gravity(@layout_gravity)
                .charge(@charge)
                .friction(0.9)
                .on "tick", (e) =>
                    @circles.each(@move_towards_center(e.alpha))
                        .attr("cx", (d) -> d.x)
                        .attr("cy", (d) -> d.y)
            @force.start()

        # Moves all circles towards the @center of the visualization
        move_towards_center: (alpha) ->
            (d) =>
                d.x = d.x + (@center.x - d.x) * (@damper + 0.02) * alpha
                d.y = d.y + (@center.y - d.y) * (@damper + 0.02) * alpha

        show_details: (data, i, element) =>
            d3.select(element).style("stroke", "black")
            bubble=$("#bub#{data.id}")
            options =
                html: true
                title: data.name
                placement: "top"
                trigger: "manual"
                container: "body"
                content: ->
                    pop ="<img src=#{data.imageUrl} class='img-responsive img-thumbnail'><br/><b>Viewers:</b><span> #{data.value}</span><br/>"
            bubble.popover(options).popover("show")

        hide_details: (data, i, element) =>
            d3.select(element).style("stroke", (d) => d3.rgb(@fill_color(d.group)).darker())
            $("#bub#{data.id}").popover("hide")

        select_details: (data, i, element) =>
            @hide_details data,i,element
            # bingo pass the model to our game detail view
            msgBus.events.trigger "app:game:detail", data.model

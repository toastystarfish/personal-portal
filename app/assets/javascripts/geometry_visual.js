
function GeometryVisual (selector, options) {
  var self = this,
      container = $(selector),
      canvas, context, interval;

  var default_options = {
    max_point_radius: 4,
    min_point_radius: 2,
    point_count: 100,
    max_connection_distance: 125,
  };

  this.state = {
    points: [],
    edges: [],
  }

  options = $.extend({}, default_options, options);

  (function initialize () {
    canvas = $('<canvas>').get(0)
    container.append(canvas);
    context = canvas.getContext("2d");

    generate_points();
  })();

  this.play = function () {
    if (!interval) {
      interval = setInterval(function () {
        update_points();
        self.draw();
      }, 25);
    }
  }

  this.stop = function () {
    clearInterval(interval);
  }

  this.draw = function () {
    set_canvas_aspect_ratio();
    draw_points();
    draw_edges();
  }

  function generate_points () {
    var pos;
    for (var i=0;i<options.point_count;i++) {
      pos = point_position();
      self.state.points.push({
        x: pos.x, y: pos.y, r: point_radius(),
        v: init_point_velocity()
      })
    }
  }

  function draw_points () {
    for (var i=0;i<self.state.points.length;i++) {
      context.beginPath();
      context.arc(self.state.points[i].x, self.state.points[i].y,
                  self.state.points[i].r, 0, 2 * Math.PI);
      context.fillStyle = "white";
      context.fill();
    }
  }

  function draw_edges () {
    self.state.edges = [];
    create_edges();
    prune_edges();

    $.each(self.state.edges, function (index, edge) {
      context.beginPath();
      context.moveTo(edge.start.x, edge.start.y);
      context.lineTo(edge.end.x, edge.end.y);
      if (edge.pruned) {
        context.strokeStyle = 'blue';
      } else {
        context.strokeStyle = 'white';
      }
      context.stroke();
    });
  }

  // prunes eges that cross other edges
  function prune_edges () {
    for (var i=0;i<self.state.edges.length;i++) {
      if (self.state.edges[i].pruned) { continue; }

      for (var j=i+1;j<self.state.edges.length;j++) {
        if (edges_intersect(self.state.edges[i], self.state.edges[j])) {
          self.state.edges.splice(j, 1);
          j--;
        }
      }
    }
  }

  function create_edges () {
    var start, end;
    for (var i=0;i<self.state.points.length;i++) {
      for (var j=i+1;j<self.state.points.length;j++) {
        start = self.state.points[i];
        end   = self.state.points[j];

        if (square_max_distance() > point_square_distance(start, end)) {
          self.state.edges.push({
            start: start,
            end: end,
            start_idx: i,
            end_idx: j
          });
        }
      }
    }
  }

  // generates a radius for a new point
  function point_radius () {
    return Math.floor(random_between(options.min_point_radius, options.max_point_radius));
  }

  function point_position () {
    return {
      x: Math.floor(random_between(options.max_point_radius, container.width() - options.max_point_radius)),
      y: Math.floor(random_between(options.max_point_radius, container.height() - options.max_point_radius)),
    };
  }

  function init_point_velocity () {
    return {
      x: random_between(-0.1, 0.1),
      y: random_between(-0.1, 0.1),
    }
  }

  function update_points () {
    $.each(self.state.points, function (idx, point) {
      var new_x = point.x + point.v.x,
          new_y = point.y + point.v.y;

      if (new_x >= canvas.width || new_x <= 0) {
        point.v.x *= -1;
      }

      if (new_y >= canvas.height || new_y <= 0) {
        point.v.y *= -1;
      }

      point.x += point.v.x
      point.y += point.v.y
    });
  }

  function set_canvas_aspect_ratio () {
    canvas.width = container[0].offsetWidth;
    canvas.height = container[0].offsetHeight
  }

  function random_between (min, max) {
    return Math.random() * (max - min) + min;
  }

  function point_square_distance (p1, p2) {
    return Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2);
  }

  function square_max_distance () {
    return Math.pow(options.max_connection_distance, 2);
  }

  function edges_intersect (edge1, edge2) {
    var x1 = edge1.start.x, x2 = edge1.end.x,
        x3 = edge2.start.x, x4 = edge2.end.x,
        y1 = edge1.start.y, y2 = edge1.end.y,
        y3 = edge2.start.y, y4 = edge2.end.y;

    if ((x1 == x3 && y1 == y3) || (x1 == x4 && y1 == y4) ||
        (x2 == x3 && y2 == y3) || (x2 == x4 && y2 == y4)) {
      // the points are shared so these intersections are allowed
      return false;
    }

    var a_dx = x2 - x1;
    var a_dy = y2 - y1;
    var b_dx = x4 - x3;
    var b_dy = y4 - y3;

    var s = (-a_dy * (x1 - x3) + a_dx * (y1 - y3)) / (-b_dx * a_dy + a_dx * b_dy);
    var t = (+b_dx * (y1 - y3) - b_dy * (x1 - x3)) / (-b_dx * a_dy + a_dx * b_dy);

    return (s >= 0 && s <= 1 && t >= 0 && t <= 1);
  }

  window.addEventListener('resize', function () {
    $.each(self.state.points, function (idx, point) {
      var oldx = point.x / canvas.width,
          oldy = point.y / canvas.height;

      point.x = oldx * container[0].offsetWidth;
      point.y = oldy * container[0].offsetHeight;
    });

    self.draw()
  });
}
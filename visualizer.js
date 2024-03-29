// Generated by CoffeeScript 1.6.2
(function() {
  var Dot, HALF_PI, PI, THREE_HALFS_PI, TWO_PI;

  PI = Math.PI;

  TWO_PI = Math.PI * 2;

  HALF_PI = Math.PI / 2;

  THREE_HALFS_PI = Math.PI * 3 / 2;

  Dot = (function() {
    function Dot(radius, center, rate, container, angle) {
      var circumference, increments;

      this.radius = radius;
      this.center = center;
      if (rate == null) {
        rate = 5;
      }
      if (container == null) {
        container = null;
      }
      this.angle = angle != null ? angle : HALF_PI;
      this.div = $('<div class="dot">');
      this.setPosition();
      this.div.appendTo(container);
      circumference = 2 * Math.PI * this.radius;
      increments = circumference / rate;
      this.angleIncrement = 360 / increments;
    }

    Dot.prototype.calculatePosition = function() {
      this.y = this.center.y - this.radius * Math.sin(this.angle);
      return this.x = this.center.x + this.radius * Math.cos(this.angle);
    };

    Dot.prototype.setPosition = function() {
      this.calculatePosition();
      return this.div.css({
        left: this.px(this.x),
        top: this.px(this.y)
      });
    };

    Dot.prototype.stepForward = function() {
      this.angle += this.angleIncrement;
      this.setPosition();
      if (this.crossedOrigin()) {
        this.updateColor();
        return this.playSound();
      }
    };

    Dot.prototype.crossedOrigin = function() {
      if (this.angle > TWO_PI) {
        this.angle -= TWO_PI;
        return true;
      }
      return false;
    };

    Dot.prototype.updateColor = function() {};

    Dot.prototype.playSound = function() {};

    Dot.prototype.px = function(pos) {
      return "" + pos + "px";
    };

    return Dot;

  })();

  $(function() {
    var body, canvas, context;

    body = $(document.body);
    canvas = $("<canvas width='" + (window.innerWidth - 17) + "' height='" + (window.innerHeight - 17) + "'>");
    body.append(canvas);
    canvas.css({
      border: "1px solid black"
    });
    canvas = canvas[0];
    context = canvas.getContext("2d");
    context.beginPath();
    context.arc(100, 100, 5, 0, TWO_PI, false);
    context.fillStyle = "#555555";
    context.fill();
    return context.stroke();
  });

}).call(this);

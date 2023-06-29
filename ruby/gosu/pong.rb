require "gosu"

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480
WHITE = Gosu::Color.argb(0xff_ffffff)

class Ball
    attr_accessor :x, :y, :vx, :vy, :radius, :speed

    def initialize
        reset
    end

    def reset
        @x = SCREEN_WIDTH / 2
        @y = SCREEN_HEIGHT / 2
        @speed = 4
        @vx = @vx && @vx < 0 ? @speed : -@speed
        @vy = 0
        @radius = 10

        bounce
    end

    def bounce
        @vy = rand() > 0.5 ? @speed / 2 : -@speed / 2
    end

    def out_to_left?
        @x + @radius * 2 < 0
    end

    def out_to_right?
        @x - @radius * 2 > SCREEN_WIDTH
    end

    def draw
        Gosu.draw_rect(@x - @radius, @y - @radius, @radius * 2, @radius * 2, WHITE, z = 0, mode = :default)
    end
    
    def update
        @x += @vx
        @y += @vy
    end
end

class Paddle
    attr_accessor :x, :y, :vx, :vy, :width, :height, :speed, :score

    def initialize(x)
        @width = 10
        @height = 100
        @score = 0
        @speed = 4
        @vy = 0
        @vx = 0
        @x = x
        @y = SCREEN_HEIGHT / 2 - @height / 2
    end

    def hit_ball(ball)
        ball.x > @x &&
        ball.x < @x + @width &&
        ball.y > @y &&
        ball.y < @y + @height
    end

    def move_on_y(target_y)
        to_vector_y = target_y - @y

        sqDist = to_vector_y * to_vector_y

        delta = @speed >= 0 && sqDist <= @speed * @speed
        if sqDist == 0 || delta
            return
        end

        @y =  @y + (to_vector_y / Math.sqrt(sqDist)) * @speed
    end

    def move_to_ball(ball)
        move_on_y(ball.y - @height / 2)
    end

    def move_to_center
        move_on_y(SCREEN_HEIGHT / 2 - @height / 2)
    end

    def draw
        Gosu.draw_rect(@x, @y, @width, @height, WHITE, z = 0, mode = :default)
    end

    def update
        @x += @vx
        @y += @vy

        if @y > 0
            @y = 0
        end

        if @y + @height > SCREEN_HEIGHT
            @y = @SCREEN_HEIGHT - @height
        end
    end
end

class Pong < Gosu::Window
    attr_accessor :ball, :left_paddle, :right_paddle, :dashes
  
  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "Pong"

    @ball = Ball.new
    @left_paddle = Paddle.new(20)
    @right_paddle = Paddle.new(SCREEN_WIDTH - 40)

    max_dashes = 100
    @dashes = Array.new(max_dashes)
    dashLength = SCREEN_HEIGHT / max_dashes
    for i in 0..max_dashes do
        @dashes[i] = Array[SCREEN_WIDTH / 2, i * 10]
    end

    @font = Gosu::Font.new(20)
  end
  
  def update
    @ball.update

    if @ball.out_to_left?
        @right_paddle.score += 1
        @ball.reset
    end

    if @ball.out_to_right?
        @left_paddle.score += 1
        @ball.reset
    end

    if @ball.y < 0
        @ball.vy = @ball.speed
    end

    if @ball.y - @ball.radius > SCREEN_HEIGHT
        @ball.vy = -@ball.speed
    end

    if @ball.vx < 0
        @left_paddle.move_to_ball(@ball)
        @right_paddle.move_to_center
    end

    if @ball.vx > 0
        @right_paddle.move_to_ball(@ball)
        @left_paddle.move_to_center
    end

    if @left_paddle.hit_ball(@ball)
        @ball.speed += 0.1
        @ball.vx = @ball.speed
        @ball.bounce
    end

    if @right_paddle.hit_ball(@ball)
        @ball.speed += 0.1
        @ball.vx = -@ball.speed
        @ball.bounce
    end
  end
  
  def draw
    @ball.draw
    @left_paddle.draw
    @right_paddle.draw

    for dash in @dashes.select.each_with_index { |_, i| i.odd? } do
        Gosu.draw_rect(dash.at(0), dash.at(1), 2, 10, WHITE, z = 0, mode = :default)
    end

    @font.draw_text_rel(@left_paddle.score.to_s + "   " + @right_paddle.score.to_s, SCREEN_WIDTH / 2, 20, 1, rel_x = 0.5, rel_y = 0.5)
  end
end

Pong.new.show
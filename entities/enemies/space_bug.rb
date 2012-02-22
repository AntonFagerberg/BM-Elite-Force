require 'entities/enemy'

class SpaceBug < Enemy
  def initialize(window)
    @window = window
    @height = 30
    @width = 30
    @speed_x = 0
    @speed_y = 0.5 + rand(10) * 0.1
    @switch_speed = 4
    @angle = 45.0
    @health = 15
    @score = 15
    @image = Gosu::Image.load_tiles(window, 'gfx/spin_bug_closed.bmp', @width, @height, true)
    @awake = false
    super()
  end

  def wake_up
    @awake = true
    @health -= 13
    @angle = 180.0
    @frames = 2
    @height = 33
    @width = 48
    @image = Gosu::Image.load_tiles(@window, 'gfx/spin_bug.bmp', @width, @height, true)
    @speed_x = 2.0 + rand(20) * 0.1
    @speed_y 	= 1.5 + rand(10) * 0.1
    direction = rand(2)
    @direction = (direction == 0) ? -1.0 : 1.0
    @start_y = @y / 50
  end

  def action(player)
    if !@awake and @y > 50 and (((@x - player.x).abs <= @collision_value + player.collision_value and player.y > @y) or ((@y - player.y).abs <= @collision_value + player.collision_value)) then
     wake_up
    end
  end

  def draw
    @image[$frame / @switch_speed % @frames].draw_rot(@x, @y, 2, @angle, 0.5, 0.5, @scale, @scale)
  end

  def update
    if @awake then
      @angle = @direction * (180 + 90 * Math::sin(@y / 50 - @start_y))
      @x += @speed_x * Math::sin(@angle / 180 * Math::PI)
    end
    @y += @speed_y
  end
end
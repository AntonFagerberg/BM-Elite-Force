require 'entities/enemy'

class Asteroid < Enemy
  def initialize(window)
    @window = window
    @height = 92
    @width = 76
    @frames = 1
    @scale = 1
    @speed_x = -0.5 + (rand(10) * 0.1)
    @speed_y = 2.0 + rand(30) * 0.1
    @angle_rotate = @speed_x + @speed_y
    @health = 3
    @score = 2
    @image = Gosu::Image.load_tiles(window, 'gfx/asteroid.bmp', @width, @height, true)
    super()
  end

  def update
    @angle += @angle_rotate
    @x += @speed_x
    @y += @speed_y
  end
end
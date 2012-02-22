require 'entities/enemies/asteroid'

class AsteroidSmall < Asteroid
  def initialize(window)
    super(window)
    @window = window
    @height = 48
    @width = 54
    @health = 2
    @score = 1
    @image = Gosu::Image.load_tiles(window, 'gfx/asteroid_small.bmp', @width, @height, true)
  end
end
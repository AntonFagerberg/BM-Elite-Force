require 'entities/enemies/asteroid'

class AsteroidBig < Asteroid
  def initialize(window)
    super(window)
    @window = window
    @height = 120
    @width = 141
    @health = 10
    @score = 3
    @image = Gosu::Image.load_tiles(window, 'gfx/asteroid_big.bmp', @width, @height, true)
  end
end
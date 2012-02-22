require 'entities/effects/explosion'

class ExplosionBig < Explosion
  def initialize(window,x ,y)
    @height = 192
    @width = 192
    @image = Gosu::Image.load_tiles(window, 'gfx/explosion_big.bmp', @width, @height, true)
    super
  end
end
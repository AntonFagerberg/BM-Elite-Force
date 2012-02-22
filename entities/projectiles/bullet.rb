require 'entities/projectile'

class Bullet < Projectile
  def initialize(window, x, y, entity)
    @entity = entity
    @x = x
    @y = y
    @height = 18
    @width = 12
    @speed = -10
    @image = Gosu::Image.load_tiles(window, 'gfx/bullet.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/bullet.wav')
    super()
    @sound.play(0.1)
  end
end

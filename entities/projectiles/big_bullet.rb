require 'entities/projectile'

class BigBullet < Projectile
  def initialize(window, x, y, entity)
    @entity = entity
    @x = x
    @y = y
    @height = 22
    @width = 14
    @speed = -10
    @image = Gosu::Image.load_tiles(window, 'gfx/big_bullet.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/big_bullet.wav')
    super()
    @sound.play(0.3)
  end
end

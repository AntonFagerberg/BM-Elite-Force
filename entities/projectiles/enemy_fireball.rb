require 'entities/projectile'

class EnemyFireball < Projectile
  def initialize(window, x, y, entity)
    @entity = entity
    @x = x
    @y = y
    @height = 56
    @width = 36
    @speed = 15
    @image = Gosu::Image.load_tiles(window, 'gfx/fireball.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/fireball.wav')
    @sound.play
    super()
  end

  def collision(entity)
    # Do nothing
  end
end
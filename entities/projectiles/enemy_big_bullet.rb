require 'entities/projectiles/big_bullet'

class EnemyBigBullet < BigBullet
  def initialize(window, x, y, entity)
    super(window, x, y, entity)
    @angle = 180
    @speed = -@speed
  end
end
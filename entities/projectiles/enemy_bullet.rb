require 'entities/projectiles/bullet'

class EnemyBullet < Bullet
  def initialize(window, x, y, entity)
    super(window, x, y, entity)
    @angle = 180
    @speed = -@speed
  end
end
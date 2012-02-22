require 'entities/entity'

class Projectile < Entity
  alias_method :super_collision, :collision

  def initialize
    @damage = 1
    super
  end

  def collision(entity)
    if super_collision(entity) and !(entity.kind_of? FireLocker and !entity.locked_player.nil?)
      if entity.kind_of? Enemy
        entity.hit(@damage)
        if entity.health <= 0 then
          @entity.score += entity.score
          entity.explode
        end
      end
      @remove = true
    end
  end

  def update
    @y += @speed
  end
end
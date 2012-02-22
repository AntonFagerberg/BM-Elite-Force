require 'entities/enemy'
require 'entities/effects/explosion_big'

class Boss < Enemy
  def initizlize
    @explode_sound = Gosu::Sample.new(@window, 'sfx/explosion_big.wav') if @explode_sound.nil?
    super
  end
  
  def explode
    @explode_sound.play
    $effects.push ExplosionBig.new(@window, @x, @y)
    @remove = true
  end
end
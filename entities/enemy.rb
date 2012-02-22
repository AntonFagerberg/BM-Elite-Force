require 'entities/entity'
require 'entities/effects/explosion'
require 'entities/items/med_pack'
require 'entities/items/battery'

class Enemy < Entity
  attr_accessor :x, :y
  attr_reader :hit_sound, :health

  def initialize
    @score = 1 if @score.nil?
    @health = 1 if @health.nil?
    @hit_sound = Gosu::Sample.new(@window, 'sfx/hit.wav') if @hit_sound.nil?
    @explode_sound = Gosu::Sample.new(@window, 'sfx/explosion_small.wav') if @explode_sound.nil?
    super()
    start_position
  end

  def start_position
    @x = 10 + rand(Size::WINDOW_WIDTH - 19)
    @y = -@height
  end

  def action(player)
  end

  def hit(damage)
    @health -= damage
    @hit_sound.play(0.3)
  end

  def explode
    random = rand(20)
    item = MedPack.new(@window) if random == 0
    item = Battery.new(@window) if random == 1
    if !item.nil? then
      item.x = @x
      item.y = @y
      $items.push item
    end

    @explode_sound.play
    $effects.push Explosion.new(@window, @x, @y)
    @remove = true
  end
end

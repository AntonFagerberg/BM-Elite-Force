require 'entities/enemy'

class FireLocker < Enemy
  attr_reader :locked_player
  alias_method :super_explode, :explode

  def initialize(window)
    @window = window
    @height = 30
    @width = 39
    @scale = 1
    @speed_x = -0.5 + rand(10) * 0.1
    @speed_y = 1.0 + rand(10) * 0.1
    @frames = 2
    @angle = 0.0
    @health = 5
    @score = 4
    @switch_speed = 10
    @hit_sound = Gosu::Sample.new(window, 'sfx/fire_locker_hit.wav')
    @lock_sound = Gosu::Sample.new(window, 'sfx/fire_locker_lock.wav')
    @all_images = Gosu::Image.load_tiles(window, 'gfx/fire_locker.bmp', @width, @height, true)
    @image = Array.new
    @image[1] = @all_images[0]
    @image[0] = @all_images[0]
    super()
  end

  def explode
    @locked_player.manual_fire = false if !@locked_player.nil?
    super_explode
  end

  def collision(entity)
    if @locked_player.nil? and Math.sqrt((@y - entity.y) ** 2 + (@x - entity.x) ** 2) <= @collision_value  + entity.collision_value then
      @locked_player = entity
      @lock_sound.play
      entity.manual_fire = true
      @image[1]	= @all_images[1]
      @lock_frame = $frame + 500
    end

    return false
  end

  def action(player)
  end

  def draw
    @image[$frame / @switch_speed % @frames].draw_rot(@x, @y, 2, @angle, 0.5, 0.5, @scale, @scale)
  end

  def update
    explode if !@lock_frame.nil? and @lock_frame < $frame
    @x = (@locked_player.nil?) ? @x + @speed_x : @locked_player.x
    @y = (@locked_player.nil?) ? @y + @speed_y : @locked_player.y
  end
end
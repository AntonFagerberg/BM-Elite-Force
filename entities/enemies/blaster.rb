require 'entities/enemy'

class Blaster < Enemy
  alias_method :super_draw, :draw
  alias_method :super_collision, :collision
  alias_method :super_explode, :explode

  def initialize(window)
    @window = window
    @height = 22
    @width = 32
    @speed_x = 0
    @speed_y = 1
    @health = 5
    @score = 20
    @green_beam = Gosu::Image.load_tiles(window, 'gfx/green_beam.bmp', 10, 600, true)
    @red_beam = Gosu::Image.load_tiles(window, 'gfx/red_beam.bmp', 3, 600, true)
    @all_images = Gosu::Image.load_tiles(window, 'gfx/blaster.bmp', @width, @height, true)
    @lock_sound = Gosu::Sample.new(window, 'sfx/blaster_lock.wav')
    @beam_sound = Gosu::Sample.new(window, 'sfx/beam.wav')
    @image = Array.new
    @image[0] = @all_images[0]
    super()
  end

  def manual_lock
    if @lock_frame.nil? and @image[0] == @all_images[0]
      @lock_sound.play
      @lock_frame = $frame + 50
      @image[0] = @all_images[1]
    end
  end

  def action(player)
    if @lock_frame.nil? and @image[0] == @all_images[0] and @y > 50 and (@x - player.x).abs <= @collision_value + player.collision_value and player.y > @y
      @lock_sound.play
      @lock_frame = $frame + 50
      @image[0] = @all_images[1]
    end

    if @kill_frame.nil? and !@lock_frame.nil? and $frame > @lock_frame and (@x - player.x).abs <= @collision_value + player.collision_value and player.y > @y
      @beam_sound.play
      @kill_frame = $frame + 5
    end
  end

  def collision(entity)
    if !@kill_frame.nil? and @beam_hit.nil? then
      @beam_hit = true
      return true
    else
      return super_collision(entity)
    end
  end

  def draw
    super_draw
    @green_beam[0].draw_rot(@x, @y + 300, 0, 0.0, 0.5, 0.5, 1, 1) if !@kill_frame.nil?
    @red_beam[0].draw_rot(@x + 1, @y + 300, 0, 0.0, 0.5, 0.5, 1, 1) if !@lock_frame.nil? and @kill_frame.nil?
  end

  def explode
    if @beam_hit.nil? or @remove then
      @remove = true
      super_explode
    end
  end

  def update
    @y += @speed_y
    @remove = (!@beam_hit.nil? and @kill_frame < $frame) if !@remove
  end
end
require 'entities/entity'
require 'entities/projectiles/bullet'
require 'entities/effects/explosion'

class Player < Entity
  attr_reader :invincible
  attr_accessor :manual_fire, :score, :hud, :health, :fire_adjustment, :ctrl_left, :ctrl_right, :ctrl_up, :ctrl_down, :ctrl_fire, :ctrl_hud, :name
  alias_method :super_draw, :draw

  def initialize
    @vel_x = 0.0 if @vel_x.nil?
    @vel_y = 0.0 if @vel_y.nil?
    @steering_x = 0.95 if @steering_x.nil?
    @steering_y = 0.95 if @steering_y.nil?
    @collision_adjustment = 10 if @collision_adjustment.nil?
    @fire_rate = 10 if @fire_rate.nil?
    @fire_adjustment = 0 if @fire_adjustment.nil?
    @health = 3 if @health.nil?
    @speed_x = 0.8 if @speed_x.nil?
    @speed_y = 0.5 if @speed_y.nil?
    @name = "Player" if @name.nil?
    @explode_sound = Gosu::Sample.new(@window, 'sfx/player_explode.wav') if @explode_sound.nil?
    @font = Gosu::Font.new(@window, 'gfx/wendy.ttf', 18)
    @hud = true if @hud.nil?
    @switch_speed = 3 if @switch_speed.nil?
    @invincible = 0 if @invincible.nil?
    @frames = 2 if @frames.nil?
    @invincible_time = 100 if @invincible_time.nil?
    @manual_fire = false if @manual_fire.nil?
    @ctrl_up = Gosu::KbUp if @ctrl_up.nil?
    @ctrl_down = Gosu::KbDown if @ctrl_down.nil?
    @ctrl_left = Gosu::KbLeft if @ctrl_left.nil?
    @ctrl_right = Gosu::KbRight if @ctrl_right.nil?
    @ctrl_fire = Gosu::KbSpace if @ctrl_fire.nil?
    @ctrl_hud = Gosu::KbRightShift if @ctrl_hud.nil?
    @next_shot = 0
    @score = 0
    @alternate = 1
    start_position
    super()
    @cannon_align = 0.8 * @mid_width if @cannon_align.nil?
  end

  def fire
    if @next_shot <= $frame
      @next_shot = $frame + @fire_rate - @fire_adjustment
      @alternate = (@alternate == -1) ? 1 : -1
      $projectiles.push Bullet.new(@window, @x + @cannon_align * @alternate, @y, self)
    end
  end

  def move_up
    @vel_y += Gosu::offset_y(0.0, @speed_y)
  end

  def move_down
    @vel_y -= Gosu::offset_y(0.0, @speed_y)
  end

  def move_left
    @vel_x += Gosu::offset_y(45.0, @speed_x)
  end

  def move_right
    @vel_x -= Gosu::offset_y(45.0, @speed_x)
  end

  def update
    new_x = @x + @vel_x
    new_y = @y + @vel_y
    max_x = Size::WINDOW_WIDTH - @mid_width
    max_y = Size::WINDOW_HEIGHT - @mid_height 

    if new_x < @mid_width or new_x > max_x then
      @x = (new_x < @mid_width) ? @mid_width : max_x
      @vel_x = 0
    else
      @x += @vel_x
    end

    if new_y < @mid_height or new_y > max_y then
      @y = (new_y < @mid_height) ? @mid_height : max_y
      @vel_y = 0
    else
      @y += @vel_y
    end

    @vel_x *= @steering_x
    @vel_y *= @steering_y
  end

  def start_position
    @y = Size::WINDOW_HEIGHT
  end

  def draw
    super_draw
    
    if @hud
      health_text = ""
      @health.times { health_text += "*" }
      @font.draw(@name, @x + (@width_scale / 2) + 10, @y - (@height_scale / 2), 1)
      @font.draw(health_text, @x + (@width_scale / 2) + 10, @y - (@height_scale / 2) + 18, 1)
      @font.draw(@score, @x + (@width_scale / 2) + 10, @y - (@height_scale / 2) + 36, 1)
    end
  end

  def explode
    @invincible = $frame + @invincible_time
    
    if @health > 0 then
      @health -= 1
    else
      @remove = true
    end

    @manual_fire = false
    @fire_adjustment = 0
    @explode_sound.play
    $effects.push Explosion.new(@window, @x, @y)
    @y = Size::WINDOW_HEIGHT - 50 if !@remove
    @vel_x = @vel_y = 0
  end
end
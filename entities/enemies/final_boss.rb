require 'entities/boss'
require 'entities/enemies/boss_bug'
require 'entities/enemies/final_mini_boss'
require 'entities/projectiles/enemy_fireball'

class FinalBoss < Boss
  attr_reader :invincible

  def initialize(window)
    @window = window
    @height = 27
    @width = 45
    @speed_x = 0
    @speed_y = 1
    @frames = 2
    @switch_speed = 8
    @angle = 0.0
    @health = 1
    @score = 1337
    @out_limit = 1000
    @invincible = 9999999
    @image = Gosu::Image.load_tiles(window, 'gfx/final_boss_small.bmp', 45, 27, true)
    @invader_new = Gosu::Image.load_tiles(@window, 'gfx/final_boss.bmp', 396, 242, true)
    @invader_old = Gosu::Image.load_tiles(@window, 'gfx/final_boss_old.bmp', 396, 242, true)
    super()
    start_position
    @start_frame = $frame
    @move_pattern = 0
    @y_move = @x_move = 0
    @y_main = 120
    @mid_window_width = Size::WINDOW_WIDTH / 2

    @dialog_font = Gosu::Font.new(window, 'gfx/wendy.ttf', 24)
    @dialog = Array.new
    @dialog.push ""
    @dialog.push "greetings earthlings"
    @dialog.push "I'm the king of the supesu inbeda"
    @dialog.push "i come in to you peace"
    @dialog.push "we surrender and we promise"
    @dialog.push "that we won't attack you ever again"
    @dialog.push "can there be peace between us?"
    @dialog.push "please spare my little life"
    @dialog.push "he he he"
  end

  def start_position
    @y = -@height
  end

  def draw
    super
    @dialog_font.draw(@dialog.at(@display_dialog), @x + 30, @y - 14, 1) if !@display_dialog.nil? and $frame - @start_frame < 2030
  end
  
  def explode
    final_mini_boss = FinalMiniBoss.new(@window)
    final_mini_boss.x = @x
    final_mini_boss.y = @y + 35
    $enemies.push final_mini_boss
    super
  end

  def update
    case @move_pattern
      when 0
        @y += 1
        if @y >= @y_main then
          @move_pattern = 1
          @display_dialog = 0
        end
      when 1
        @x = (Size::WINDOW_WIDTH / 2) + 10 * Math.sin(@x_move)
        @x_move += 0.1
        @display_dialog = ((@display_dialog.nil?) ? 0 : @display_dialog + 1) if $frame % 200 == 0 and @display_dialog < @dialog.size
        @y -= 2 if @display_dialog == @dialog.size - 1
        if $frame - @start_frame > 2030 then
          @health = 500 * $multiplier
          @move_pattern = 4 
          @collision_adjustment = 15
          @x_move = @y_move = 0
          @height = 242
          @width = 396
          @y = -@height
          @x = @mid_width + rand(Size::WINDOW_WIDTH - @mid_width)
          @switch_speed = 6
          @frames = 2
          @image = @invader_new
          @width_scale = @width * @scale
          @height_scale = @height * @scale
          @smallest_side = (@width_scale <= @height_scale) ? @width_scale : @height_scale
          @collision_value = (@smallest_side / 2) - @collision_adjustment
          @mid_width = @width * @scale / 2
          @mid_height = @height * @scale / 2
          @invincible = 0
        end
      when 2
        @y = @y_main + 50 * Math.sin(@y_move)
        @x = (Size::WINDOW_WIDTH / 2) + (Size::WINDOW_WIDTH / 3.3) * Math.sin(@x_move)
        @x_move += 0.03 + (((500 * $multiplier) - @health) * 0.0001)
        @y_move += 0.01

        if $frame % (50 + (@health / 15).to_i) == 0 then
          @projectile_side = (rand(2) == 0) ? 1 : -1
          $enemy_projectiles.push EnemyFireball.new(@window, @x + @projectile_side * (@mid_width - 50), @y + @mid_height - 40, self)
        end

        if $frame % 500 == 0 then
          $players.each do
            boss_bug = BossBug.new(@window)
            boss_bug.x = @x
            boss_bug.y = @y + 35
            $enemies.push boss_bug
          end
        end
        
        if rand(500) == 0 then
          @image = @invader_old
          @frames = 1
          @move_pattern = 3 
        end
      when 3
        @y -= 2 if @y > -200
        if @y <= -200 then
          @x = @mid_width + rand(Size::WINDOW_WIDTH - (2 * @mid_width))
          @move_pattern = 4
        end
      when 4
        if @y < Size::WINDOW_HEIGHT - @mid_height then
          @y += 20 
        else
          @move_pattern = 5
        end
      when 5
        @y -= 2 if @y >= @y_main
        
        if @x.between?(@mid_window_width - 2, @mid_window_width + 2) then
          @x = @mid_window_width
        else
          @x = (@x > @mid_window_width) ? @x - 2 : @x + 2
        end

        if @y <= @y_main then
          @x_move = @y_move = 0
          @move_pattern = 2
          @image = @invader_new
          @frames = 2
        end
    end
  end
end

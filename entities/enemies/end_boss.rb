require 'entities/boss'
require 'entities/projectiles/enemy_fireball'

class EndBoss < Boss
  def initialize(window)
    @window = window
    @height= 144
    @width = 212
    @scale = 1
    @speed_x = 0
    @speed_y = 1
    @frames = 2
    @switch_speed = 8
    @angle = 0.0
    @health = 99999
    @score = 100
    @out_limit = 200
    @image = Gosu::Image.load_tiles(window, 'gfx/end_boss.bmp', @width, @height, true)
    super()
    @move_pattern = 0
    @y_move = @x_move = 0
    @half_width = Size::WINDOW_WIDTH / 2
    @align_1 = Size::WINDOW_WIDTH / 2.3
    @align_2 = Size::WINDOW_WIDTH / 2.2
    start_position
  end

  def start_position
    @x = @half_width
    @y = -@height
  end

  def update
    case @move_pattern
        when 0
            @y += 1
            @move_pattern = 1 if @y > 100
        when 1
            @y = 100 + 30 * Math.sin(@y_move)
            @x = (@half_width) + (@align_1) * Math.sin(@x_move)
            @y_move += 0.1
            @x_move += 0.02
            @move_pattern = 2 if rand(500) == 0 and $frame <= 21800
            if $frame > 21850 and @x.between?((Size::WINDOW_WIDTH / 2) + 300 * Math.cos(0.1) - 5, (Size::WINDOW_WIDTH / 2) + 300 * Math.cos(0.1) + 5) then
                @move_pattern = 4
                @x_move = 0.1
            end
        when 2
            @x = (@half_width) + (@align_1) * Math.sin(@x_move)
            @y += 10
            @x_move += 0.02
            @move_pattern = 3 if @y > Size::WINDOW_HEIGHT
        when 3
            @x = (@half_width) + (@align_1) * Math.sin(@x_move)
            @y -= 5
            @x_move += 0.02
            if @y <= 100 then
                @move_pattern = 1 
                @y_move = 0
            end
        when 4
            @x = (@half_width) + 300 * Math.cos(@x_move)
            @x_move *= 1.0075
            if $frame > 23150 then
                @move_pattern = 5 
                @x_move = @y_move = 0
                @health = $multiplier * 100
            end
        when 5
            @y = 100 + 10 * Math.sin(@y_move)
            @x = (@half_width) + (@align_2) * Math.sin(@x_move)
            @y_move += 0.1
            @x_move += 0.05
            $enemy_projectiles.push EnemyFireball.new(@window, @x, @y, self) if $frame % 35 == 0
    end
  end
end

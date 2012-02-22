require 'entities/boss'

class MidBoss < Boss
  alias_method :super_explode, :explode

  def initialize(window)
    @window = window
    @height = 172
    @width = 214
    @scale = 1
    @speed_x = 0
    @speed_y = 1
    @frames = 1
    @switch_speed = 1
    @angle = 0.0
    @health = 100 * $multiplier
    @score = 50
    @fire_rate = 13
    @z = 3
    @image = Gosu::Image.load_tiles(window, 'gfx/mid_boss.bmp', @width, @height, true)
    @y_move = 0.0
    @x_move = 0.0
    @right_cannon = true
    super()
    start_position
  end
  
  def explode
    super_explode
    $toasty = Toasty.new(@window)
    $music["level1"].volume = 0.1
  end

  def start_position
    @x = Size::WINDOW_WIDTH/2
    @y = -@mid_height
  end

  def update
    if @go_right.nil? then
      @y += 1
      @go_right = true if @y >= 130
    else
      @current_fire_rate = @fire_rate + (@health / 10)
      @y_move += 0.1
      @x_move += 0.03
      @y = 130 + 30 * Math.sin(@y_move)
      @x = (Size::WINDOW_WIDTH / 2) + (Size::WINDOW_WIDTH / 3) * Math.sin(@x_move)
      @fire_x = (@right_cannon) ? 35 + @x - @mid_width : -10 + @x + @mid_width
      
      if $frame % @current_fire_rate == 0 then
        @right_cannon = !@right_cannon
        $enemy_projectiles.push EnemyBigBullet.new(@window, @fire_x,@y + @mid_height, self)
        $enemy_projectiles.push EnemyBigBullet.new(@window, @fire_x - 25,@y + @mid_height , self)
      end
    end
  end
end

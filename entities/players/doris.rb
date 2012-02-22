require 'entities/player'

class Doris < Player
  def initialize(window)
    @window = window
    @height = 60
    @width = 45
    @speed_x = 0.5
    @speed_y = 0.5
    @fire_rate = 18
    @health = 4
    @image = Gosu::Image.load_tiles(window, 'gfx/doris.bmp', @width, @height, true)
    super()
  end

  def start_position
    @x = 50
    super
  end

  def fire
    if @next_shot <= $frame
      @next_shot = $frame + @fire_rate - @fire_adjustment
      $projectiles.push Bullet.new(@window, @x - @cannon_align, @y, self)
      $projectiles.push Bullet.new(@window, @x + @cannon_align, @y, self)
    end
  end
end
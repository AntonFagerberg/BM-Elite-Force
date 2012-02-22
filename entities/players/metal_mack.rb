require 'entities/player'

class MetalMack < Player
  def initialize(window)
    @window = window
    @height = 60
    @width = 45
    @fire_rate = 13
    @image = Gosu::Image.load_tiles(window, 'gfx/widunder.bmp', @width, @height, true)
    super()
  end

  def start_position
    @x = 800
    super
  end

  def fire
    if @next_shot <= $frame
      @next_shot = $frame + @fire_rate - @fire_adjustment
      $projectiles.push Bullet.new(@window, @x, @y - @mid_height, self)
    end
  end
end
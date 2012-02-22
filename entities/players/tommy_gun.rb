require 'entities/player'

class TommyGun < Player
  def initialize(window)
    @window = window
    @height = 60
    @width = 48
    @fire_rate = 35
    @image = Gosu::Image.load_tiles(window, 'gfx/tommy_gun.bmp', @width, @height, true)
    super()
  end

  def start_position
    @x = 550
    super
  end

  def fire
    if @next_shot <= $frame
      @next_shot = $frame + @fire_rate - @fire_adjustment
      $projectiles.push Bullet.new(@window, @x, @y - @mid_height, self)
      $projectiles.push Bullet.new(@window, @x + 15, @y - @mid_height + 20, self)
      $projectiles.push Bullet.new(@window, @x - 15, @y - @mid_height + 20, self)
    end
  end
end
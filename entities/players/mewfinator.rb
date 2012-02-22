require 'entities/player'

class Mewfinator < Player
  def initialize(window)
    @window = window
    @height = 57
    @width = 45
    @speed_x = 1.0
    @speed_y = 0.9
    @image = Gosu::Image.load_tiles(window, 'gfx/mewfinator.bmp', @width, @height, true)
    super()
  end

  def start_position
    @x = 350
    super
  end
end
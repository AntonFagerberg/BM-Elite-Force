require 'entities/player'

class Dunderino < Player
  def initialize(window)
    @window = window
    @height = 60
    @width = 45
    @speed_y = 0.6
    @image = Gosu::Image.load_tiles(window, 'gfx/dunderino.bmp', @width, @height, true)
    super()
  end

  def start_position
    @x = 200
    super
  end
end
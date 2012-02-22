require 'entities/player'

class MonkeyCat < Player
  def initialize(window)
    @window = window
    @height = 60
    @width = 45
    @image = Gosu::Image.load_tiles(window, 'gfx/monkey_cat.bmp', @width, @height, true)
    super()
  end
  def start_position
    @x = 700
    super
  end
end
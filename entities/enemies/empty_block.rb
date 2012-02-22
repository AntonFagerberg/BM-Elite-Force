require 'entities/enemy'

class EmptyBlock < Enemy
  def initialize(window)
    @height = 20
    @width = 15
    @frames = 1
    @scale = 3
    super()
    @angle_rotate = @speed_x + @speed_y
    @image = Gosu::Image.load_tiles(window, 'gfx/empty_block.bmp', @width, @height, true)
  end

  def update
  end

  def start_position
    @x = @y = 400
  end
end
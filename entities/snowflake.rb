require 'entities/entity'

class SnowFlake < Entity
  def initialize(window)
    @window = window
    @height = 1
    @width = 1
    @y = -@height
    @x = rand(Size::WINDOW_WIDTH)
    @z = 5
    @y_speed = 0.2 + rand(11) * 0.1
    @scale = rand(5)
    @image = Gosu::Image.load_tiles(window, 'gfx/white_pixel.bmp', @width, @height, true)
    @x_trig = 0
    @x_move = rand(10) * 0.1 
    @trig_function = rand(2)
    super()
  end
  
  def update
    @y += @y_speed
    @x = (@trig_function == 1) ? @x + @x_move*Math.sin(@x_trig) : @x + @x_move*Math.cos(@x_trig)
    @x_trig += 0.05
  end
end
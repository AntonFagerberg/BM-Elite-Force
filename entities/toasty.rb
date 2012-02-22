require 'entities/entity'

class Toasty < Entity
  def initialize(window)
    @window = window
    @height = 190
    @width = 170
    @image = Gosu::Image.load_tiles(window, 'gfx/toasty.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/toasty.wav')
    super()
    @x = Size::WINDOW_WIDTH + @mid_width
    @y = Size::WINDOW_HEIGHT - @mid_height
  end
  
  def remove
    return (!@remove_frame.nil? and @remove_frame < $frame)
  end

  def update
    if @x > Size::WINDOW_WIDTH - @mid_width + 10 and @remove_frame.nil? then
      @x -= 10
    elsif @remove_frame.nil?
      @remove_frame = $frame + 75 
      @sound.play(1.0)
    end
    
    @x += 10 if !@remove_frame.nil? and $frame + 20 > @remove_frame
  end
end
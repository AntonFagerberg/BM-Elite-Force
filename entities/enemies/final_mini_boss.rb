require 'entities/enemy'

class FinalMiniBoss < Enemy
  def initialize(window)
    @window = window
    @height = 27
    @width = 45
    @frames = 2
    @switch_speed = 8
    @health = 10
    @score = 13
    @image = Gosu::Image.load_tiles(window, 'gfx/final_boss_small.bmp', @width, @height, true);
    @wilhelm = Gosu::Sample.new(window, 'sfx/wilhelm.mp3')
    @x_move = 0.0
    @out_limit = 1000
    super()
  end

  def explode
    @wilhelm.play
    super
  end
  
  def update
    @y -= 1 if @y > 100
    @y += 1 if @y < 100
    @x = (Size::WINDOW_WIDTH / 2) + 10 * Math.sin(@x_move)
    @x_move += 0.1
  end
end
require 'entities/entity'

class Explosion < Entity
  alias_method :super_draw, :draw
  attr_reader :done

  def initialize(window,x ,y)
    @window = window
    @height = 96 if @height.nil?
    @width = 96 if @width.nil?
    @frames = 6
    @switch_speed = 3
    @x = x
    @y = y
    @image = Gosu::Image.load_tiles(window, 'gfx/explosion.bmp', @width, @height, true) if @image.nil?
    @frame = 0
    @done = false
    super()
  end

  def update
    @frame += 1
    @remove = @frame >= @frames*@switch_speed
  end

  def draw
    out_of_screen
    @image[@frame / @switch_speed].draw_rot(@x, @y, 2, @angle, 0.5, 0.5, @scale, @scale)
  end
end
require 'entities/enemy'

class Spinner < Enemy
  alias_method :super_explode, :explode
  
  def initialize(window)
    @window = window
    @height = 30
    @width = 33
    @speed_x = -0.5 + rand(10) * 0.1
    @speed_y = 2.0 + rand(20) * 0.1
    @frames = 4
    @health = 10
    @score = 5
    @switch_speed = 6
    @image = Gosu::Image.load_tiles(window, 'gfx/spinner.bmp', @width, @height, true)
    @hit_sound = Gosu::Sample.new(window, 'sfx/lock_mine_hit.wav')
    super()
  end

  def explode
    random = rand(2)
    item = MedPack.new(@window) if random == 0
    item = Battery.new(@window) if random == 1
    item.x = @x
    item.y = @y
    $items.push item
    super_explode
  end

  def update
    @x += @speed_x
    @y += @speed_y
  end
end

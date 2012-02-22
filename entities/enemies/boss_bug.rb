require 'entities/enemy'

class BossBug < Enemy
  alias_method :super_explode, :explode
  
  def initialize(window)
    @window = window
    @height = 24
    @width = 39
    @speed_x = 1
    @speed_y = 1
    @frames = 2
    @switch_speed = 4
    @angle = 180.0
    @health = 2
    @out_limit = 400
    @score = 11
    @image = Gosu::Image.load_tiles(window, 'gfx/boss_bug.bmp', @width, @height, true)
    @circle = 1
    @sin_add = 0
    @direction = rand(2)
    super()
  end


  def action(player)
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
    if @direction == 0 then
      @x = @x + @circle * Math.sin(@sin_add)
      @y = @y + @circle * Math.cos(@sin_add)
      @angle = -1* @sin_add / Math::PI * 180 + 180
    else
      @x = @x + @circle * Math.cos(@sin_add)
      @y = @y + @circle * Math.sin(@sin_add)
      @angle = @sin_add / Math::PI * 180 + 90
    end
    @sin_add += 0.04
    @circle += 0.04
  end
end
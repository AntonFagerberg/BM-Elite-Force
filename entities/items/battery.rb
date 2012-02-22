require 'entities/item'

class Battery < Item
  def initialize(window)
    @window = window
    @height = 20
    @width = 10
    @speed_y = 1
    @switch_speed = 5
    @frames = 5
    @image = Gosu::Image.load_tiles(window, 'gfx/bullet_battery.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/battery.wav')
    super()
  end

  def update
    @y += @speed_y
  end

  def perform(player)
    player.fire_adjustment += 1 if player.fire_adjustment <= 5
    @sound.play
  end
end
require 'entities/item'

class MedPack < Item
  def initialize(window)
    @window = window
    @height = 11
    @width = 14
    @speed_y = 1
    @switch_speed = 6
    @frames = 6
    @image = Gosu::Image.load_tiles(window, 'gfx/med_pack.bmp', @width, @height, true)
    @sound = Gosu::Sample.new(window, 'sfx/med_pack.wav')
    super()
  end

  def update
    @y += @speed_y
  end

  def perform(player)
    player.health += 1
    @sound.play
  end
end
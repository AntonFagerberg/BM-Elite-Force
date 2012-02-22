require 'backgrounds/background'

class SpaceBackground < Background
  attr_accessor :scroll_speed

  def initialize(window, window_height)
    @background = Gosu::Image.new(window, "gfx/space_background.bmp", true)
    @length = 1800
    @scroll_speed = 2
    @window_height = window_height
  end
end
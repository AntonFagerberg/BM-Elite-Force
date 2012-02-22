require 'levels/level'
require 'backgrounds/space_background'

class Intro < Level
  def initialize(window)
    super()
    @window = window
    @background = SpaceBackground.new(window, Size::WINDOW_HEIGHT)
    @background.scroll_speed = 0
    @scroll_text = Array.new
    @scroll_font = Gosu::Font.new(window, 'gfx/wendy.ttf', 64)
    @black_pixel = Gosu::Image.new(window, 'gfx/black_pixel.bmp', true)
    @anton = Gosu::Image.new(window, 'gfx/anton_fagerberg.bmp', true)
    @sabrepulse = Gosu::Image.new(window, 'gfx/music.jpg', true)
    #$music["intro"] = Gosu::Song.new(window, "sfx/intro.mp3") if !$music.key? "intro"
    #$music["intro"].play
    $frame = 0
    @text_space = 75
    @bp_position = 0
    @black = 0
    @text_position = Size::WINDOW_HEIGHT

    @scroll_text.push "In 1978, the first alien attack"
    @scroll_text.push "was made by the supesu inbeda."
    @scroll_text.push ""
    @scroll_text.push "Armed only with tanks and"
    @scroll_text.push "fragile roofs for protection"
    @scroll_text.push "the human race was able to"
    @scroll_text.push "fight them off."
    @scroll_text.push ""
    @scroll_text.push "The earth was however left in"
    @scroll_text.push "chaos and destruction."
    @scroll_text.push ""
    @scroll_text.push "Fearing the return of the"
    @scroll_text.push "supesu inbeda, human alliance"
    @scroll_text.push "president tomohiro nishikado"
    @scroll_text.push "enlisted the six bravest men"
    @scroll_text.push "as fighter pilots to combat"
    @scroll_text.push "future threats."
    @scroll_text.push ""
    @scroll_text.push "we now believe that the"
    @scroll_text.push "supesu inbeda are once again"
    @scroll_text.push "on their way towards earth."
    @scroll_text.push ""
    @scroll_text.push ""
    @scroll_text.push ""
    @scroll_text.push "but this time there is hope..."
    $frame = 0
  end

  def update
    @scroll_text.first
    @text_position -= 1 if $frame > 650
    @bp_position += 10
    if @bp_position.between?(0, 10) and $frame > 800 then
      @bp_position = 0
      @done = true
    end
    @bp_position = - Size::WINDOW_WIDTH if $frame == 300 - Size::WINDOW_WIDTH/10 or $frame == 600 - Size::WINDOW_WIDTH/10 or @text_position + @scroll_text.size * @text_space - 150  == Size::WINDOW_HEIGHT / 2
    #$music["intro"].volume -= 0.01 if @text_position + @scroll_text.size * @text_space - 250  < (Size::WINDOW_HEIGHT / 2)
  end

  def draw
    @background.draw
    text_margin = 0
    @scroll_text.each do |text|
      text_margin += @text_space
      @scroll_font.draw(text, 25, @text_position + text_margin, 1)
    end
    @anton.draw(0, 0, 1) if $frame.between?(0, 300)
    @sabrepulse.draw(0, 0, 1) if $frame.between?(301, 600)
    @black_pixel.draw(@bp_position, 0, 1, Size::WINDOW_WIDTH, Size::WINDOW_HEIGHT)
  end

  def skip
    @done = true
  end
end

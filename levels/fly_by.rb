require 'levels/level'
require 'backgrounds/space_background'
require 'entities/players/monkey_cat'
require 'entities/players/mewfinator'
require 'entities/players/tommy_gun'
require 'entities/players/dunderino'
require 'entities/players/doris'
require 'entities/players/metal_mack'

class FlyBy < Level
  def initialize(window)
  super()
    @window = window
    @background = SpaceBackground.new(window, Size::WINDOW_HEIGHT)

    @players = Array.new
    @players.push Mewfinator.new(window)
    @players.push TommyGun.new(window)
    @players.push Dunderino.new(window)
    @players.push Doris.new(window)
    @players.push MetalMack.new(window)
    @players.push MonkeyCat.new(window)

    @players.each do |player|
      player.hud = false
    end

    @font_80 = Gosu::Font.new(window, 'gfx/wendy.ttf', 80)
    @font_60 = Gosu::Font.new(window, 'gfx/wendy.ttf', 60)
    @font_40 = Gosu::Font.new(window, 'gfx/wendy.ttf', 40)
    @black_pixel = Gosu::Image.new(window, 'gfx/black_pixel.bmp', true)

    start_position = 0
    @players.each do |player|
      player.x = 65 + (Size::WINDOW_WIDTH / 6) * start_position
      player.y = Size::WINDOW_HEIGHT - 75
      start_position += 1
    end

    @text_y	= Size::WINDOW_HEIGHT + 1000
    #$music["fly_by"] = Gosu::Song.new(window, "sfx/fly_by.ogg") if !$music.key? "fly_by"
    #$music["fly_by"].play
    $frame = 0
  end

  def update
    #puts $frame
    @players[0].y -= 5 if $frame > 340 and @players[0].y > 50 and @text_y == Size::WINDOW_HEIGHT + 1000
    @players[1].y -= 5 if $frame > 340 and @players[1].y > 125 and @text_y == Size::WINDOW_HEIGHT + 1000
    @players[2].y -= 5 if $frame > 510 and @players[2].y > 200 and @text_y == Size::WINDOW_HEIGHT + 1000
    @players[3].y -= 5 if $frame > 510 and @players[3].y > 275 and @text_y == Size::WINDOW_HEIGHT + 1000
    @players[4].y -= 5 if $frame > 690 and @players[4].y > 350 and @text_y == Size::WINDOW_HEIGHT + 1000
    @players[5].y -= 5 if $frame > 690 and @players[5].y > 425 and @text_y == Size::WINDOW_HEIGHT + 1000

    if $frame > 1000 and @text_y >= 200
      @players.each do |player|
        player.y -= 5
      end
      @text_y = @players[5].y + Size::WINDOW_HEIGHT / 2 if @players[5].y < Size::WINDOW_HEIGHT - 80
    end

    if $frame == 1150
      @players[0].y = Size::WINDOW_HEIGHT + 160
      @players[1].y = Size::WINDOW_HEIGHT + 120
      @players[2].y = Size::WINDOW_HEIGHT + 60
      @players[3].y = Size::WINDOW_HEIGHT + 60
      @players[4].y = Size::WINDOW_HEIGHT + 120
      @players[5].y = Size::WINDOW_HEIGHT + 160
    end

    if $frame > 1150
      @players[0].y = @players[0].y - 7 if @players[0].y > 160
      @players[1].y = @players[1].y - 7 if @players[1].y > 120
      @players[2].y = @players[2].y - 7 if @players[2].y > 60
      @players[3].y = @players[3].y - 7 if @players[3].y > 60
      @players[4].y = @players[4].y - 7 if @players[4].y > 120
      @players[5].y = @players[5].y - 7 if @players[5].y > 160
    end
  end

  def draw
    @font_60.draw('The Mewfinator', @players[0].x + 50, @players[0].y - @players[0].mid_height, 1) if @players[0].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @font_60.draw('TommyGun', @players[1].x + 50, @players[1].y - @players[1].mid_height, 1) if @players[1].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @font_60.draw('El Dunderino', @players[2].x + 50, @players[2].y - @players[2].mid_height, 1) if @players[2].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @font_60.draw('Little Doris', @players[3].x - 320, @players[3].y - @players[3].mid_height, 1) if @players[3].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @font_60.draw('metal mack', @players[4].x - 310, @players[4].y - @players[4].mid_height, 1) if @players[4].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @font_60.draw('monkeycat', @players[5].x - 280, @players[5].y - @players[5].mid_height, 1) if @players[5].y < Size::WINDOW_HEIGHT - 120 and $frame < 1150
    @black_pixel.draw($frame * 15, 0, 10, Size::WINDOW_WIDTH, Size::WINDOW_HEIGHT)
    @font_80.draw('Bm elite force', 175, @text_y, 1)
    @font_40.draw('- press enter to start -', 205, @text_y + 100, 1) if $frame / 20 % 5 < 4
    @background.draw
    @players.each { |player| player.draw }
  end

  def skip
    #@click_sound.play
    @done = true
  end
end
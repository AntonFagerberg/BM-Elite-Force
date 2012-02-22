# encoding: utf-8

require 'levels/level'
require 'backgrounds/space_background'
require 'entities/snowflake'
require 'entities/players/monkey_cat'
require 'entities/players/mewfinator'
require 'entities/players/tommy_gun'
require 'entities/players/dunderino'
require 'entities/players/doris'
require 'entities/players/metal_mack'

class Ending < Level
  def initialize(window)
  	super()
  	@window = window
  	@snow_flakes = Array.new
  	$frame = -300
    @font_40 = Gosu::Font.new(window, 'gfx/wendy.ttf', 40)
    @font_60 = Gosu::Font.new(window, 'gfx/wendy.ttf', 40)
    @font_80 = Gosu::Font.new(window, 'gfx/wendy.ttf', 80)
    @anton = Gosu::Image.new(window, 'gfx/anton_fagerberg.bmp', true)
    @players = Array.new
    @mewfinator = Mewfinator.new(window)
    @players.push @mewfinator
    @tommygun = TommyGun.new(window)
    @players.push @tommygun
    @dunderino = Dunderino.new(window) 
    @players.push @dunderino
    @doris = Doris.new(window)
    @players.push @doris
    @metal_mack = MetalMack.new(window)
    @players.push @metal_mack
    @monkeycat = MonkeyCat.new(window)
    @players.push @monkeycat
    @dinosaurmas_y = 0.0

    n = 1
    @players.each do |player|
      player.angle = 90
      player.x = - 600 * (Size::WINDOW_WIDTH/Size::WINDOW_HEIGHT) * n * 2
      player.y = 100 - 600 * (Size::WINDOW_WIDTH/Size::WINDOW_HEIGHT) * n
      player.hud = false if !player.kind_of? Boss
      n += 1
    end

    #$music["ending"] = Gosu::Song.new(window, "sfx/ending.mp3") if !$music.key? "ending"
    #$music["ending"].volume = 1.0
  end

  def update
    #$music["ending"].play if $frame == 0
    @snow_flakes.push SnowFlake.new(@window) if @snow_flakes.size < 1000 and $frame % 3 == 0 and $frame > 810
    
    @snow_flakes.each do |snow_flake|
      snow_flake.update
      @snow_flakes.delete(snow_flake) if snow_flake.remove
    end
    
    @text_y = Size::WINDOW_HEIGHT if $frame == 1200
    @text_y -= 1 if $frame.between?(1201, 1780)
    
    if $frame > 1000
      n = 0
      @players.each do |player|
        player.x += 1
        player.y += 0.5
        n += 1
      end
    end
    
    @anton_y = Size::WINDOW_HEIGHT if @anton_y.nil? and @monkeycat.x > Size::WINDOW_WIDTH + 100
    @anton_y = (@anton_y <= 0) ? 0 : @anton_y - 1 if !@anton_y.nil?
  end
  
  def draw
    @snow_flakes.each { |snow_flake| snow_flake.draw }
    @font_40.draw('as the heroes approached earth...', 100, 100, 5) if $frame.between?(100,299)
    @font_40.draw('descending through the night sky...', 150, 150, 5) if $frame.between?(400,599)
    @font_40.draw('snow began to fall...', 330, 200, 5) if $frame.between?(800,999)
    
    @font_80.draw('Merry Dinosaurmas', 105, @text_y + 5 * Math.sin(@dinosaurmas_y += 0.05), 5) if !@text_y.nil? 
    
    if $frame > 1750 then
      @players.each { |player| player.draw }
      @font_60.draw('Johan Möller', @mewfinator.x -  255,  @mewfinator.y - 20, 5)
      @font_60.draw('Tommy Rosen', @tommygun.x -  245,  @tommygun.y - 20, 5)
      @font_60.draw('Alexander Lieszkovszki', @dunderino.x - 405,  @dunderino.y - 20, 5)
      @font_60.draw('Jens Fredriksson', @doris.x -  310,  @doris.y - 20, 5)
      @font_60.draw('Markus Hammarstedt', @metal_mack.x -  375,  @metal_mack.y - 20, 5)
      @font_60.draw('Wishes Anton Fagerberg', @monkeycat.x -  420,  @monkeycat.y - 20, 5)
      @anton.draw(0, @anton_y, 1) if !@anton_y.nil?
    end
  end
  
  def skip
  	#@click_sound.play
  	#@done = true
  end
end
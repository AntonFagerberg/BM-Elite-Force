require 'levels/level'
require 'backgrounds/space_background'
require 'entities/players/monkey_cat'
require 'entities/players/mewfinator'
require 'entities/players/tommy_gun'
require 'entities/players/dunderino'
require 'entities/players/doris'
require 'entities/players/metal_mack'

class Restart < Level
  def initialize(window)
		super()
		@window 		= window
		@background		= SpaceBackground.new(window, Size::WINDOW_HEIGHT)
		@black_pixel		= Gosu::Image.new(window, 'gfx/black_pixel.bmp', true)
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
		
		@big_font = Gosu::Font.new(window, 'gfx/wendy.ttf', 80)
		@small_font = Gosu::Font.new(window, 'gfx/wendy.ttf', 40)
		start_position = 0

		@players[5].y = Size::WINDOW_HEIGHT / 2

		#$music["restart"] = Gosu::Song.new(window, "sfx/restart.mp3") if !$music.key? "restart"
		#$music["restart"].play
		$frame = 0
		@x_move = @y_move = @player_move = 0
		@Delay = Math::PI / 3
  end

  def update
		position = 0
		@players.each	do |player|
			position += 1
			player.y = Size::WINDOW_HEIGHT / 2 + 270 * Math.sin(@player_move - @Delay * position)
			player.x = Size::WINDOW_WIDTH / 2 + 270 * Math.cos(@player_move - @Delay * position)
			player.angle = ((@player_move  - @Delay * position) / Math::PI) * 180 + 180
		end

		@x_move += 0.1
    @player_move += 0.02 
  end
  
  def draw
	  position_x = Size::WINDOW_HEIGHT / 2 + 10 * Math.sin(@x_move)
	  @black_pixel.draw($frame * 15, 0, 10, Size::WINDOW_WIDTH, Size::WINDOW_HEIGHT)
	  @big_font.draw('Game Over', 245, position_x - 60, 1)
		@small_font.draw('- press enter to restart -', 190, position_x + 20, 1) if $frame / 20 % 5 < 4
		@background.draw
		@players.each { |player| player.draw }
  end
  
  def skip
		#@click_sound.play
		@done = true
  end
end
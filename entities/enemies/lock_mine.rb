require 'entities/enemy'

class LockMine < Enemy
  def initialize(window)
    @window = window
    @height = 27
    @width = 27
    @scale = 1
    @speed_x = -0.5 + rand(10) * 0.1
    @speed_y = 1.0 + rand(20) * 0.1
    @frames = 1
    @health = 5
    @score = 6
    @angle = 180.0
    @all_images = Gosu::Image.load_tiles(window, 'gfx/lock_mine.bmp', @width, @height, true)
    @lock_sound = Gosu::Sample.new(window, 'sfx/lock_mine_lock.wav')
    @image = Array.new
    @image[0] = @all_images[0]
    @positive = @speed_x >= 0
    super()
  end

  def action(player)
    if @image[0] == @all_images[0] and (@y - player.y).abs <= @collision_value + player.collision_value
      @player = player
      @speed_y = 4.0
      @speed_x = (player.x > x) ? 8.0 : -8.0
      @image[0] = @all_images[1]
      @lock_sound.play
    end
  end

  def update
    if !@player.nil?
      @x += @speed_x
    end
      @y += @speed_y if @player.nil? or (@y - @player.y).abs > @collision_value + @player.collision_value
    end
end

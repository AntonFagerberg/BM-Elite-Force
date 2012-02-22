require 'entities/enemies/missile'

class MissileBig < Missile
  def initialize(window)
    super(window)
    @height = 30
    @width = 45
    @speed_x = -0.5 + rand(10) * 0.1
    @speed_y = 1.0 + rand(20) * 0.1
    @angle = 180.0
    @health = 2
    @score = 10
    @lock_sound = Gosu::Sample.new(window, 'sfx/missile_big_lock.wav')
    @all_images = Gosu::Image.load_tiles(window, 'gfx/missile_big.bmp', @width, @height, true)
    @image[0] = @all_images[1]
  end

  def action(player)
    if @image[0] == @all_images[1] and @y > 100 and (@x - player.x).abs <= @collision_value + player.collision_value and player.y > @y
      @speed_y = 20.0
      @lock_sound.play
      @image[0] = @all_images[0]
    end
  end

  def update
    @x += @speed_x
    @y += @speed_y
  end
end
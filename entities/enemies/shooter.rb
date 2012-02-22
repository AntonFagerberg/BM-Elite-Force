require 'entities/enemy'
require 'entities/projectiles/enemy_big_bullet'

class Shooter < Enemy
  def initialize(window)
    @window = window
    @height = 21
    @width = 36
    @speed_x = -2.0 + rand(40) * 0.1
    @speed_y = 2.0 + rand(20) * 0.1
    @frames = 2
    @switch_speed = 6
    @health = 3
    @score = 6
    @fire_rate = 50 - rand(15)
    @image = Gosu::Image.load_tiles(window, 'gfx/shooter.bmp', @width, @height, true)
    super()
  end

  def update
    @x += @speed_x
    @y += @speed_y
    $enemy_projectiles.push EnemyBigBullet.new(@window, @x, @y + @height_scale, self) if $frame % @fire_rate == 0
  end
end
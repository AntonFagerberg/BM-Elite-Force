require 'levels/level'
require 'backgrounds/space_background'
require 'entities/toasty'
require 'entities/enemies/asteroid_big'
require 'entities/enemies/asteroid_small'
require 'entities/enemies/missile'
require 'entities/enemies/missile_big'
require 'entities/enemies/empty_block'
require 'entities/enemies/lock_mine'
require 'entities/enemies/blaster'
require 'entities/enemies/shooter'
require 'entities/enemies/spinner'
require 'entities/enemies/fire_locker'
require 'entities/enemies/space_bug'
require 'entities/enemies/end_boss'
require 'entities/enemies/final_boss'
require 'entities/enemies/mid_boss'
require 'player_controls'

class MainLevel < Level
  attr_reader :players

  def initialize(window)
    super()
    @window = window
    @background = SpaceBackground.new(@window, Size::WINDOW_HEIGHT)
    $players = Array.new
    $enemies = Array.new
    $items = Array.new
    $projectiles = Array.new
    $enemy_projectiles = Array.new
    $effects = Array.new

    init_players(window)

    @drawable = Array.new
    @drawable.push @background
    @drawable.push $players
    @drawable.push $enemies
    @drawable.push $projectiles
    @drawable.push $enemy_projectiles
    @drawable.push $items
    @drawable.push $effects

    @black_pixel = Gosu::Image.new(window, 'gfx/black_pixel.bmp', true)

    #$music["level1"] = Gosu::Song.new(window, "sfx/level1.ogg") if !$music.key? "level1"
    #$music["end_boss"] = Gosu::Song.new(window, "sfx/end_boss.mp3") if !$music.key? "end_boss"
    #$music["final_boss"] = Gosu::Song.new(window, "sfx/final_boss.m4a") if !$music.key? "final_boss"
    #$music["level1"].volume = 1.0
    #$music["level1"].play
    $frame = 0
  end

  def update
    enemy_wave

    @done_frame = $frame + 100 if $players.size == 0 and @done_frame.nil?
    @done = true if !@done_frame.nil? and $frame > @done_frame
    
    if !@done_frame.nil? then
      #$music["level1"].volume -= 0.01 
      @bp_slide = (@done_frame >= $frame) ? - (@done_frame - $frame) : 0
    end

    $players.each do |player|
      player.update

      player.move_up if @window.button_down? player.ctrl_up
      player.move_down if @window.button_down? player.ctrl_down
      player.move_left if @window.button_down? player.ctrl_left
      player.move_right if @window.button_down? player.ctrl_right
      player.fire if @window.button_down? player.ctrl_fire if !player.manual_fire

      $enemy_projectiles.each do |projectile|
        $enemy_projectiles.delete(projectile) if projectile.y > Size::WINDOW_HEIGHT + 50
        if player.collision(projectile) then
          player.explode
          $enemy_projectiles.delete(projectile)
        end
      end

      $items.each do |item|
        if item.collision(player)
          item.perform(player)
          $items.delete item
        end
      end

      $players.delete(player) if player.remove
    end

    $effects.each do |effect|
      effect.update
      $effects.delete(effect) if effect.remove
    end

    $items.each do |item|
      item.update
      $items.delete(item) if item.remove
    end

    $projectiles.each do |projectile|
      projectile.update
      $projectiles.delete(projectile) if projectile.remove
    end

    $enemy_projectiles.each do |projectile|
      projectile.update
      $projectiles.each do |player_projectile|
        if projectile.collision(player_projectile) then
          projectile.remove = true
          player_projectile.remove = true
        end
      end
      $enemy_projectiles.delete(projectile) if projectile.remove
    end

    $enemies.each do |enemy|
      enemy.update
      $projectiles.each { |projectile| projectile.collision(enemy) }

      $players.each do |player|
        enemy.action(player)

        if enemy.collision(player)
          player.explode
          enemy.explode if !enemy.kind_of? Boss # Flying into bosses won't kill them.
          $enemies.each { |enemy| enemy.remove = true if enemy.y >= 300 and !enemy.kind_of? Boss } # Remove enemies from spawn area.
        end
      end

      $enemies.delete(enemy) if enemy.remove
    end
    
    if !$toasty.nil? then
      $toasty.update
      if $toasty.remove then
        #$music["level1"].volume = 1.0
        $toasty = nil
      end
    end
  end

  def draw
    @drawable.each do |drawable|
      if drawable.kind_of? Array then
        drawable.each { |draw_item| draw_item.draw }
      else
        drawable.draw
      end
    end

    $toasty.draw if !$toasty.nil?
    @black_pixel.draw(@bp_slide*Size::WINDOW_WIDTH / 100, 0, 10, Size::WINDOW_WIDTH, Size::WINDOW_HEIGHT) if !@bp_slide.nil?
  end

  def enemy_wave
    if $frame.between?(100,1000) and $frame % 50 == 0 then
      random = rand(6)
      $enemies.push AsteroidSmall.new(@window) if random.between?(0,3)
      $enemies.push Asteroid.new(@window) if random.between?(3,4)
      $enemies.push AsteroidBig.new(@window) if random == 5
    end

    if $frame.between?(1200, 2000) and $frame % 20 == 0 then
      $multiplier.times do
        $enemies.push Missile.new(@window)
      end
    end

    if $frame.between?(2100, 2600) and $frame % 200 == 0 then
      $multiplier.times do
        $enemies.push Blaster.new(@window)
      end
    end

    if $frame.between?(3000,4000) and $frame % 30 == 0 then
      random = rand(7)
      $enemies.push AsteroidSmall.new(@window) if random.between?(0,3)
      $enemies.push Asteroid.new(@window) if random.between?(3,4)
      $enemies.push AsteroidBig.new(@window) if random == 5
      $enemies.push Spinner.new(@window) if random == 6
    end

    if $frame.between?(4200,4800) and $frame % 250 == 0 then
      $multiplier.times do
        $enemies.push LockMine.new(@window)
        $enemies.push Shooter.new(@window)
      end
    end

    if $frame == 5100 then
      margin = 0
      line_width = Size::WINDOW_WIDTH / 4
      (Size::WINDOW_WIDTH / line_width + 1).times do
        $enemies.push Blaster.new(@window)
        blaster = $enemies.last
        blaster.x = line_width * margin
        blaster.manual_lock
        $enemies.push LockMine.new(@window)
        margin += 1
      end
    end

    if $frame == 5250 then
      @background.scroll_speed = 4
    end

    if $frame.between?(5500, 6000) and $frame % 100 == 0 then
      $enemies.push FireLocker.new(@window)
      missile_line
      $multiplier.times do
        $enemies.push Shooter.new(@window)
      end
    end

    if $frame.between?(6550, 6850) and $frame % 25 == 0 then
      mine_hug
      if $frame % 150 == 0 then
        $multiplier.times { $enemies.push MissileBig.new(@window) }
      end
    end

    if $frame == 6600 then
      @background.scroll_speed = 6
      margin = 0
      line_width = Size::WINDOW_WIDTH / 2
      (Size::WINDOW_WIDTH / line_width + 1).times do
        $enemies.push Blaster.new(@window)
        blaster = $enemies.last
        blaster.x = line_width*margin
        blaster.manual_lock
        margin += 1
      end
    end

    if $frame.between?(7000, 7500) and $frame % 50 == 0 then
      $multiplier.times do
        $enemies.push Shooter.new(@window)
        $enemies.push Spinner.new(@window)
      end
    end

    if $frame.between?(7500, 9000) and $frame % 50 == 0 then
      $multiplier.times do
        $enemies.push Shooter.new(@window)
        $enemies.push Missile.new(@window) if $frame % 150 == 0
        if $frame % 200 == 0 then
          $enemies.push AsteroidSmall.new(@window)
          $enemies.push MissileBig.new(@window)
        end
        $enemies.push Spinner.new(@window) if $frame % 250 == 0
        if $frame % 300 == 0 then
          $enemies.push LockMine.new(@window)
          $enemies.push Blaster.new(@window)
        end
      end
    end

    if $frame == 9500 then
      $enemies.push MidBoss.new(@window)
      boss = $enemies.last
      margin = 0
      line_width = Size::WINDOW_WIDTH / $multiplier
      (Size::WINDOW_WIDTH / line_width + 1).times do
        $enemies.push Blaster.new(@window)
        blaster = $enemies.last
        if margin == 0 then
          blaster.x = blaster.width * blaster.scale
        elsif (line_width * margin) == Size::WINDOW_WIDTH then
          blaster.x = Size::WINDOW_WIDTH - (blaster.width * blaster.scale)
        else
          blaster.x = line_width * margin
        end
        blaster.y = blaster.height * blaster.scale
        blaster.speed_y = 0
        blaster.manual_lock
        margin += 1
      end
    end

    if $frame.between?(10000, 13000) and $enemy_projectiles.size == 0 and $frame % 100 == 0 then
      $enemies.push FireLocker.new(@window)
    end

    if $frame.between?(10000, 13000) and $enemy_projectiles.size == 0 and $frame % 20 == 0 then
      $multiplier.times do
        random = rand(9)
        $enemies.push AsteroidSmall.new(@window) if random.between?(0,2)
        $enemies.push Asteroid.new(@window) if random.between?(3,5)
        $enemies.push AsteroidBig.new(@window) if random.between?(6,7)
        $enemies.push LockMine.new(@window) if random == 7
      end
    end

    $enemies.each { |enemy| enemy.explode } if $frame == 13500

    if $frame.between?(13600, 15000) and $frame % 100 == 0 then
      $multiplier.times do
        $enemies.push SpaceBug.new(@window)
        random = rand(9)
        $enemies.push AsteroidSmall.new(@window) if random.between?(0,2)
        $enemies.push Asteroid.new(@window) if random.between?(3,5)
        $enemies.push AsteroidBig.new(@window) if random.between?(6,7)
        $enemies.push LockMine.new(@window) if random == 7
      end
    end

    if $frame == 15550 then
      position_x = Size::WINDOW_WIDTH / ($multiplier + 2)
      n = 0
      ($multiplier + 1).times do
        n += 1
        blaster = Blaster.new(@window)
        blaster.x = position_x * n
        blaster.speed_y = 0.3
        blaster.manual_lock
        $enemies.push blaster
      end
    end

    if $frame.between?(15550, 16900) and $frame % 50 == 0 then
      $enemies.push FireLocker.new(@window)
      amount = (6*$multiplier);
      row = Size::WINDOW_WIDTH / amount
      x = 0
      (amount).times do
        x += 1
        space_bug = SpaceBug.new(@window)
        space_bug.x = row*x
        space_bug.y -= 15 * (rand(20) * 0.1)
        space_bug.wake_up
        $enemies.push space_bug
      end
    end

    if $frame.between?(17000, 18500) and $frame % 50 == 0 then
      random = rand(6)
      $enemies.push AsteroidSmall.new(@window) if random.between?(0,3)
      $enemies.push Asteroid.new(@window) if random.between?(3,4)
      $enemies.push AsteroidBig.new(@window) if random == 5
    end

    $enemies.push FireLocker.new(@window) if $frame.between?(17100, 18400) and $frame % 500 == 0
    $enemies.push Missile.new(@window) if $frame.between?(17200, 18400) and $frame % 150 == 0
    $enemies.push MissileBig.new(@window) if $frame.between?(17500, 18400) and $frame % 100 == 0
    $enemies.push Blaster.new(@window) if $frame.between?(17700, 18400) and $frame % 200 == 0
    $enemies.push LockMine.new(@window) if $frame.between?(18000, 18400) and $frame % 100 == 0
    $enemies.push Shooter.new(@window) if $frame.between?(18200, 18400) and $frame % 50 == 0
    $enemies.push Spinner.new(@window) if $frame.between?(18000, 18400) and $frame % 75 == 0

    if $frame.between?(18000, 18400) and $frame % 50 == 0 then
      space_bug = SpaceBug.new(@window) 
      space_bug.y -= 15 * (rand(20) * 0.1)
      $enemies.push space_bug
    end

    if $frame.between?(18600, 18700) then
      $music["level1"].volume -= 0.01
    end

    if $frame == 19200 then
      #$music["level1"].stop
      #$music["end_boss"].volume = 1.0
      #$music["end_boss"].play
      $enemies.clear
      $enemies.push EndBoss.new(@window)
    end

    if $frame > 19200 then

      @kill_frame = $frame + 500 if @kill_frame.nil? and $frame > 19200 and $enemies.size == 0
      #$music["end_boss"].volume -= 0.01 if !@kill_frame.nil? and @kill_frame > $frame

      if !@kill_frame.nil? and @kill_frame == $frame then
        #$music["end_boss"].stop
        #$music["final_boss"].volume = 1.0
        #$music["final_boss"].play
        $enemies.push FinalBoss.new(@window)
        @final_boss = true
      end
      
      #$music["final_boss"].volume -= 0.01 if !@final_boss.nil? and !@done_frame.nil?
      #$music["final_boss"].stop if $music["final_boss"].volume <= 0
      
      @done_frame = $frame + 100 if $players.size != 0 and !@final_boss.nil? and @done_frame.nil? and $enemies.size == 0
      #@done = true if !@done_frame.nil? and $frame > @done_frame
    end
  end

  def mine_hug
    $enemies.push LockMine.new(@window)
    lock_mine = $enemies.last
    lock_mine.speed_y = 2
    lock_mine.x = ($frame % 50 == 0) ? 30 : lock_mine.x = Size::WINDOW_WIDTH - 30
  end

  def missile_line
    margin = 0
    line_width = 50
    ((Size::WINDOW_WIDTH / line_width)+1).times do
      $enemies.push Missile.new(@window)
      missile = $enemies.last
      missile.x = line_width*margin
      missile.speed_x = 0
      missile.speed_y = 1
      margin += 1
    end
  end
end
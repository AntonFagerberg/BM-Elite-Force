$LOAD_PATH.unshift File.dirname(__FILE__)
require 'rubygems'
require 'gosu'
require 'constants'
require 'levels/intro'
require 'levels/fly_by'
require 'levels/main_level'
require 'levels/restart'
require 'levels/ending'

class GameWindow < Gosu::Window
  def initialize
    super(Size::WINDOW_WIDTH, Size::WINDOW_HEIGHT, false)
    self.caption = ""
    $music = Hash.new
    $frame = 0
    $multiplier = 1
    @current_level = Intro.new(self)
  end

  def update
    if @current_level.done then
      if @current_level.kind_of? MainLevel and !$players.nil? and $players.size == 0 then
        @current_level = Restart.new(self) 
      elsif @current_level.kind_of? MainLevel and !$players.nil? and $players.size != 0 then
        @current_level = Ending.new(self) 
      elsif @current_level.kind_of? FlyBy or @current_level.kind_of? Restart then
        @current_level = MainLevel.new(self) 
      elsif @current_level.kind_of? Intro then
        @current_level = FlyBy.new(self)
      end
    end

    @current_level.update
    $frame += 1
  end

  def button_up(id)
    if !$players.nil?
      $players.each do |player|
        player.hud = !player.hud if id == player.ctrl_hud
        player.fire if id == player.ctrl_fire and player.manual_fire
      end
    end

    @current_level.skip if @current_level.respond_to?('skip') and id == Gosu::KbReturn
  end

  def button_down(id)
    if id == Gosu::KbEscape
     close
    end
  end

  def draw
    @current_level.draw
  end
end

GameWindow.new.show
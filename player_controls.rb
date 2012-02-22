require 'entities/players/monkey_cat'
require 'entities/players/mewfinator'
require 'entities/players/tommy_gun'
require 'entities/players/dunderino'
require 'entities/players/doris'
require 'entities/players/metal_mack'

def init_players(window)
  player1 = MonkeyCat.new(window)
  player1.name = "Anton"
  player1.ctrl_up = Gosu::KbUp
  player1.ctrl_down = Gosu::KbDown
  player1.ctrl_left = Gosu::KbLeft
  player1.ctrl_right = Gosu::KbRight
  player1.ctrl_fire = Gosu::KbSpace#RightAlt
  player1.ctrl_hud = Gosu::KbRightShift
  $players.push player1

  player2 = TommyGun.new(window)
  player2.name = "Tommy"
  player2.ctrl_up = Gosu::KbW
  player2.ctrl_down = Gosu::KbS
  player2.ctrl_left = Gosu::KbA
  player2.ctrl_right = Gosu::KbD
  player2.ctrl_fire = Gosu::KbQ
  player2.ctrl_hud = Gosu::KbE
  #$players.push player2

  player3 = Doris.new(window)
  player3.name = "Jens"
  player3.ctrl_up = Gosu::KbT
  player3.ctrl_down = Gosu::KbG
  player3.ctrl_left = Gosu::KbF
  player3.ctrl_right = Gosu::KbH
  player3.ctrl_fire = Gosu::KbR
  player3.ctrl_hud = Gosu::KbY
  #$players.push player3

  player4 = Mewfinator.new(window)
  player4.name = "Johan"
  player4.ctrl_up = Gosu::KbI
  player4.ctrl_down = Gosu::KbK
  player4.ctrl_left = Gosu::KbJ
  player4.ctrl_right = Gosu::KbL
  player4.ctrl_fire = Gosu::KbU
  player4.ctrl_hud = Gosu::KbO
  #$players.push player4

  #player5 = MonkeyCat.new(window)
  #player5.name = "Player"
  #$players.push player5
  
  #player6 = Doris.new(window)
  #$players.push player6
end
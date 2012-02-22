require 'entities/entity'

class Item < Entity
  def initialize
    @collision_adjustment = 3
    start_position
    super
  end

  def start_position
    @x = 10 + rand(Size::WINDOW_WIDTH - 19)
    @y = -@height
  end

  def perform(player)
  end
end
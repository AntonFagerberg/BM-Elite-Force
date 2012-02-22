class Entity
  attr_accessor :x, :y, :speed_x, :speed_y, :remove, :angle
  attr_reader :score, :height, :width, :scale, :mid_height, :mid_width, :collision_value

  def initialize
    @angle = 0.0 if @angle.nil?
    @angle_rotate = 0.0 if @angle_rotate.nil?
    @x = Size::WINDOW_WIDTH / 2 if @x.nil?
    @y = Size::WINDOW_HEIGHT / 2 if @y.nil?
    @speed_x = 0.8 if @speed_x.nil?
    @speed_y = 0.5 if @speed_y.nil?
    @switch_speed = 3 if @switch_speed.nil?
    @frames = 1 if @frames.nil?
    @collision_adjustment = 0 if @collision_adjustment.nil?
    @scale = 1 if @scale.nil?
    @width_scale = @width * @scale
    @height_scale = @height * @scale
    @smallest_side = (@width_scale <= @height_scale) ? @width_scale : @height_scale
    @collision_value = (@smallest_side / 2) + @collision_adjustment
    @mid_width = @width * @scale / 2
    @mid_height = @height * @scale / 2
    @remove = false if @remove.nil?
    @out_limit = 100 if @out_limit.nil?
    @z = 1 if @z.nil?
  end

  def out_of_screen
    @remove = (@y > Size::WINDOW_HEIGHT + @out_limit or @y < -@out_limit or @x > Size::WINDOW_WIDTH + @out_limit or @x < -@out_limit) if !@remove
  end

  def collision(entity)
    return (entity.respond_to?('invincible') and entity.invincible > $frame) ? false : Math.sqrt((@y - entity.y)**2 + (@x - entity.x)**2) <= @collision_value + @collision_adjustment  + entity.collision_value
  end

  def draw
    out_of_screen
    @image[$frame / @switch_speed % @frames].draw_rot(@x, @y, @z, @angle, 0.5, 0.5, @scale, @scale)
  end
end

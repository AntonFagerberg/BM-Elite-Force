class Background
  def draw
    @position = -@length + @window_height if @position.nil? or @position >= 0
    @background.draw(0, @position += @scroll_speed, 0)
  end
end
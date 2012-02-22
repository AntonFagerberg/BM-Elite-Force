class Level
  attr_reader :done
  
  def initialize
    @done = false if @done.nil?
  end
end

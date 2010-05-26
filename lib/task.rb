class Task
  attr_reader :name, :duration
  COLUMN_WIDTH = 6
  
  def initialize(name, duration)
    @name = name
    @duration = Duration.new(duration)
  end
  
  def update_duration(duration_string)
    @duration += Duration.new(duration_string)
  end
  
  def summary
    "#{@name}: #{@duration.value.to_s.rjust(COLUMN_WIDTH)}"
  end
end
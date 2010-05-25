class Task
  attr_reader :duration
  
  def initialize(name, duration)
    @name = name
    @duration = Duration.new(duration)
  end
  
  def update_duration(duration_string)
    @duration += Duration.new(duration_string)
  end
  
  def summary
    "#{@name}: #{@duration.value.to_s.rjust(5)}"
  end
end
class Duration
  attr_reader :hours, :minutes, :seconds
  
  def initialize(duration_string)
    @hours, @minutes, @seconds = duration_string.split(":").map{|e| e.to_f}
  end
  
  def value
    v = @hours + (@minutes / 60) + (@seconds / (60 * 60))
    sprintf("%0.02f", v).to_f
  end
  
  def +(other)
    @hours += other.hours
    @minutes += other.minutes
    @seconds += other.seconds
    self
  end
end
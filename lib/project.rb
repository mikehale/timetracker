class Project
  attr_reader :name, :days
  REPORT_WIDTH = 120
  
  def initialize(name)
    @name = name
    @days = []
  end
  
  def add_or_update_day(date, task_name, duration_string)
    day = @days.detect {|day| day.date == date }
    unless day
      @days << Day.new(date, Task.new(task_name, duration_string))
    else
      day.add_task(task_name, duration_string)
    end
  end
  
  def total_hours
    days.inject(0.0) do |total, day|
      total += day.hours_worked
    end
  end
  
  def summary
    total_line = "Total hours: #{total_hours.to_s.rjust(6)}"
%(
Project: #{@name}
Date #{'Hours'.rjust(14)} Task(s)
#{"".rjust(REPORT_WIDTH, "-")}
#{days.map{|e| e.summary + "\n"} }
#{total_line}
#{"".rjust(REPORT_WIDTH, "=")}
)
  end
end
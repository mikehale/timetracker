class Project
  attr_reader :name, :tasks
  REPORT_WIDTH = 120
  
  def initialize(name)
    @name = name
    @tasks = {}
  end
  
  def add_task(task_name, duration)
    task = tasks[task_name]
    if task
      task.update_duration(duration)
    else
      tasks[task_name] = Task.new(task_name, duration)
    end
  end
  
  def summary
    total_hours = tasks.values.inject(0.0) do |total_hours, task|
      total_hours += task.duration.value
    end
    total_line = "Total hours: #{total_hours.to_s.rjust(Task::COLUMN_WIDTH)}"
%(
Project: #{@name}
#{@tasks.values.map{|e| e.summary.rjust(REPORT_WIDTH) + "\n"} }
#{total_line.rjust(REPORT_WIDTH)}
#{"".rjust(REPORT_WIDTH, "=")}
)
  end
end
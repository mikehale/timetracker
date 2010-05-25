class Project
  attr_reader :name, :tasks
  
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
    total_hours= tasks.values.inject(0.0) do |total_hours, task|
      total_hours += task.duration.value
    end

%(
Project: #{@name}
#{@tasks.values.map{|e| e.summary.rjust(120) + "\n"} }
#{"".rjust(120, "=")}
Total hours: #{total_hours}
)
  end
end
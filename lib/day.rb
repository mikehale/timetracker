class Day
  attr_reader :date, :tasks
  
  def initialize(date, task)
    @date = date
    @tasks = []
    @tasks << task
  end
  
  def add_task(task_name, duration_string)
    task = tasks.detect {|task| task.name == task_name}
    if task
      task.update_duration(duration_string)
    else
      tasks << Task.new(task_name, duration_string)
    end
  end
  
  def hours_worked
    tasks.inject(Duration.new) {|total_duration, task| total_duration += task.duration }.value
  end
  
  def summary
    task_line = "#{tasks.map {|task| task.name }.join(', ').wrap(104, 20)}"
    "#{date.strftime('%Y-%m-%d')} #{hours_worked.to_s.rjust(8)} #{task_line}"
  end
end
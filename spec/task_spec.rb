require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'report'
require 'task'

describe Task do
  
  before(:each) do
    prepare_report
    project = @report.projects.detect {|name, project| name == "project1" }.last
    @task = project.days.first.tasks.first
  end

  describe "summary" do
    it "should include the task name" do
      @task.summary.should include("task1")
    end
  end
  
  it "should have the correct duration" do
    @task.duration.value.should == 0.51
  end
end

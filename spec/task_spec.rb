require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'report'
require 'report_spec_helper'
require 'task'

describe Task do
  include ReportSpecHelper
  
  before(:each) do
    prepare_report
    project = @report.projects.detect {|name, project| name == "project1" }.last
    @task = project.tasks.values.first
  end

  describe "summary" do
    it "should include the task name" do
      @task.summary.should include("task1")
    end
  end
  
  it "should have the correct duration" do
    @task.duration.value.should == 2.2
  end
end

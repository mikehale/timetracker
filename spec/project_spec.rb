require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'report'
require 'report_spec_helper'
require 'project'

describe Project do
  include ReportSpecHelper
  
  before(:each) do
    prepare_report
    @report.file
    @project = @report.projects.detect {|name, project| name == "project1" }.last
  end

  describe "summary" do
    it "should include the project name" do
      @project.summary.should include("Project: project1")
    end
    
    it "should have the correct number of tasks" do
      @project.tasks.should have(4).things
    end

    it "should list the tasks for each project" do
      @project.summary.should include("task1")
      @project.summary.should include("task2")
      @project.summary.should include("task3")
      @project.summary.should include("task4")
    end

    it "should include the total hours" do
      @report.summary.should include("Total hours: 5.72")
    end
  end
end


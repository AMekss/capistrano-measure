require 'spec_helper'
require 'capistrano/measure/timer'
require 'capistrano/measure/log_reporter'
require 'capistrano/measure/adapter'

describe Capistrano::Measure::Adapter do
  let(:logger) { ::StringLogger.new }
  subject { Capistrano::Measure::Adapter.new(logger) }

  it "end-to-end test" do
    subject.before_task('root_task')
    subject.before_task('sub_task')
    subject.before_task('sub_task1')
    subject.after_task('sub_task1')
    subject.after_task('sub_task')
    subject.before_task('sub_task')
    subject.after_task('sub_task')
    subject.after_task('root_task')

    subject.print_report

    expect(logger.to_s).not_to be_empty
  end

  describe "::capistrano_version" do
    subject { Capistrano::Measure::Adapter }

    it "should return nil if Capistrano version isn't recognizable" do
      expect(subject.capistrano_version).to be_nil
    end

    it "should detect Capistrano 2 version" do
      stub_const('Capistrano::Version::MAJOR', 2)
      expect(subject.capistrano_version).to eq 2
    end

    it "should detect Capistrano 3 version" do
      stub_const('Capistrano::VERSION', '3.0.1')
      expect(subject.capistrano_version).to eq 3
    end
  end

end

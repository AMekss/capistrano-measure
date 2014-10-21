module Capistrano
  module Measure
    class Adapter

      def self.capistrano_version
        return ::Capistrano::Version::MAJOR.to_i if defined?(::Capistrano::Version::MAJOR)
        return ::Capistrano::VERSION[0].to_i if defined?(::Capistrano::VERSION)
        nil
      end

      def initialize(logger=nil)
        @timer = Capistrano::Measure::Timer.new
        @log_reporter = Capistrano::Measure::LogReporter.new(logger)
      end

      def before_task(task_name)
        @timer.start(task_name)
      end

      def after_task(task_name)
        @timer.stop(task_name)
      end

      def print_report
        @log_reporter.render(@timer.report_events)
      end

    end
  end
end

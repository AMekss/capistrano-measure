module Capistrano
  module Measure
    class Adapter

      def self.capistrano_version
        return ::Capistrano::Version::MAJOR.to_i if defined?(::Capistrano::Version::MAJOR)
        return ::Capistrano::VERSION[0].to_i if defined?(::Capistrano::VERSION)
        nil
      end

      def initialize(logger, config)
        @logger = logger
        @config = config
      end

      def before_task(task_name)
        timer.start(task_name)
      end

      def after_task(task_name)
        timer.stop(task_name)
      end

      def print_report
        log_reporter.render(timer.report_events)
      end

      private

      attr_reader :logger, :config

      def log_reporter
        @log_reporter ||= Capistrano::Measure::LogReporter.new(logger, config)
      end

      def timer
        @timer ||= Capistrano::Measure::Timer.new
      end

    end
  end
end

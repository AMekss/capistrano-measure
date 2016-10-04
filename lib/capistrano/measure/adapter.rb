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
        @valid = true
      end

      def before_task(task_name)
        with_error_handling { timer.start(task_name) }
      end

      def after_task(task_name)
        with_error_handling { timer.stop(task_name) }
      end

      def print_report
        if valid?
          log_reporter.render(timer.report_events)
        else
          log_reporter.render_error("Capistrano::Measure plugin encountered an error during performance evaluation and is not able to present a performance report, in order to `raise` and troubleshoot this error add `set :measure_error_handling, :raise` into your capistrano config")
        end
      end

      private

      attr_reader :logger, :config

      def log_reporter
        @log_reporter ||= Capistrano::Measure::LogReporter.new(logger, config)
      end

      def timer
        @timer ||= Capistrano::Measure::Timer.new
      end

      def debug?
        config.fetch(:measure_error_handling, :silent) == :raise
      end

      def valid?
        @valid
      end

      def with_error_handling
        yield
      rescue StandardError => e
        @valid = false
        raise e if debug?
      end

    end
  end
end

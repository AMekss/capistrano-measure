require 'colorized_string'
require 'logger'

module Capistrano
  module Measure
    class LogReporter

      attr_reader :alert_threshold, :warning_threshold

      DEFALUT_ALERT_THRESHOLD = 60
      DEFAULT_WARNING_THRESHOLD = 30

      def initialize(logger, config)
        @logger = logger
        @alert_threshold = config.fetch(:alert_threshold, DEFALUT_ALERT_THRESHOLD)
        @warning_threshold = config.fetch(:warning_threshold, DEFAULT_WARNING_THRESHOLD)
      end

      def render(events)
        return if events.to_a.empty?

        with_layout do
          events.each do |event|
            log "#{'..' * event.indent}#{event.name} #{colorize_time(event.elapsed_time)}"
          end
        end
      end

      def render_error(message)
        with_layout do
          @logger.error message
        end
      end

      private

      def with_layout
        log_sepertor
        log ColorizedString["  Performance Report"].green
        log_sepertor
        yield
        log_sepertor
      end

      def log_sepertor
        log "=" * 60
      end

      def log(text)
        @logger.info text
      end

      def colorize_time(time_spent)
        return if time_spent.nil?
        ColorizedString["#{time_spent}s"].colorize(color(time_spent))
      end

      def color(time_spent)
        (time_spent > alert_threshold ? :red : (time_spent > warning_threshold ? :yellow : :green))
      end
    end
  end
end

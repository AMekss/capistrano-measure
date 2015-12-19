require 'colored'
require 'logger'

module Capistrano
  module Measure
    class LogReporter

      attr_reader :alert_threshold, :warning_threshold

      DEFALUT_ALERT_THRESHOLD = 60
      DEFAULT_WARNING_THRESHOLD = 30

      def initialize(logger=nil)
        @logger = logger || ::Logger.new(STDOUT)
        @alert_threshold = fetch :alert_threshold, DEFALUT_ALERT_THRESHOLD
        @warning_threshold = fetch :warning_threshold, DEFAULT_WARNING_THRESHOLD
      end

      def render(events)
        return if events.to_a.empty?

        log_sepertor
        log "  Performance Report".green
        log_sepertor

        events.each do |event|
          log "#{'..' * event.indent}#{event.name} #{colorize_time(event.elapsed_time)}"
        end
        log_sepertor
      end

      private

      def log_sepertor
        log "=========================================================="
      end

      def log(text)
        @logger.info text
      end

      def colorize_time(time_spent)
        return if time_spent.nil?
        color = (time_spent > alert_threshold ? :red : (time_spent > warning_threshold ? :yellow : :green))
        "#{time_spent}s".send(color)
      end

    end
  end
end

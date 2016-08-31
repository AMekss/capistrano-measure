require 'colorize'
require 'logger'

module Capistrano
  module Measure
    class LogReporter
      ALERT_TRASHOLD = 60
      WARNING_TRASHOLD = 30

      def initialize(logger=nil)
        @logger = logger || ::Logger.new(STDOUT)
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
        color = (time_spent > ALERT_TRASHOLD ? :red : (time_spent > WARNING_TRASHOLD ? :yellow : :green))
        "#{time_spent}s".send(color)
      end

    end
  end
end

module Capistrano
  module Measure
    class Timer
      attr_reader :events

      Event = Struct.new(:name, :action, :time, :indent, :elapsed_time) do
        def id
          "#{name}_#{indent}".freeze
        end

        def eq?(event)
          id == event.id
        end

        def start?
          action == :start
        end
      end

      def initialize
        @indent = 0
        @open_events = []
        @events = []
      end

      def start(event_name)
        event = Event.new(event_name, :start, Time.now, @indent)
        @open_events << event
        @events << event
        @indent += 1

        event
      end

      def stop(event_name)
        event = close_event(event_name)
        @open_events.pop
        @events << event
        @indent = event.indent

        event
      end

      def report_events
        raise 'Performance measure is not completed' unless @open_events.empty?
        return to_enum(__callee__) unless block_given?

        (events + [Event.new]).each_cons(2) do |event, next_event|
          yield event unless event.start? && event.eq?(next_event)
        end
      end

      private

      def close_event(event_name)
        event = Event.new(event_name, :stop, Time.now, @indent-1)
        open_event = @open_events.last
        raise "You're trying to stop unstarted event" unless event.eq?(open_event)

        event.elapsed_time = (event.time - open_event.time).to_i
        event
      end

    end
  end
end

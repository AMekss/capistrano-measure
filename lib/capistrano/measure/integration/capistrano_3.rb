module Capistrano
  module Measure
    module Integration
      module Capistrano3
        def measure_adapter
          @measure_adapter ||= Capistrano::Measure::Adapter.new
        end

        def insert_measuer_tasks
          Rake.application.tasks.each do |current_task|
            before(current_task, :"bm_#{current_task}_before_hook") do
              measure_adapter.before_task(current_task)
            end

            after(current_task, :"bm_#{current_task}_after_hook") do
              measure_adapter.after_task(current_task)
            end
          end
        end

        def invoke_task(task_string)
          name, _ = parse_task_string(task_string)

          insert_measuer_tasks if top_level_tasks.first == name
          super(task_string)
          measure_adapter.print_report if top_level_tasks.last == name
        end
      end
    end
  end
end

module Capistrano
  class Application
    include Capistrano::Measure::Integration::Capistrano3
  end
end

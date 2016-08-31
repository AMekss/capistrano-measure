Capistrano::Configuration.instance(:must_exist).load do |config|
  adapter = Capistrano::Measure::Adapter.new(logger, config)

  on :before do
    adapter.before_task(current_task.fully_qualified_name)
  end

  on :after do
    adapter.after_task(current_task.fully_qualified_name)
  end

  config.on :exit do
    adapter.print_report
  end
end

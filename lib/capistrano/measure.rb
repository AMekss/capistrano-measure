require 'capistrano'
require 'capistrano/measure/version'
require 'capistrano/measure/timer'
require 'capistrano/measure/log_reporter'
require 'capistrano/measure/adapter'

case ::Capistrano::Measure::Adapter::capistrano_version
when 2
  require 'capistrano/measure/integration/capistrano_2'
when 3
  require 'capistrano/measure/integration/capistrano_3'
else
  raise 'This version of Capistrano is not supported.'
end

module Capistrano
  module Measure

  end
end

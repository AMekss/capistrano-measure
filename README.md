# Capistrano::Measure - deployment speed measure tool
[![Gem Version](https://badge.fury.io/rb/capistrano-measure.svg)](https://badge.fury.io/rb/capistrano-measure)
[![Build Status](https://travis-ci.org/AMekss/capistrano-measure.svg?branch=master)](https://travis-ci.org/AMekss/capistrano-measure)

In order to improve something you have to measure it! This helps you measure performance of your Capistrano deployments by appending performance reports after each Capistrano execution

Works with **Capistrano 2** and **Capistrano 3**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-measure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-measure

Enable it in `Capfile`

    require 'capistrano/measure'

## Usage
It will append every capistrano execution with similar report

    ...
    INFO[adb409a1] Finished in 0.050 seconds with exit status 0 (successful).
    I, [2014-10-23T18:10:31.384161 #14352]  INFO -- : ==========================================================
    I, [2014-10-23T18:10:31.384214 #14352]  INFO -- :   Performance Report
    I, [2014-10-23T18:10:31.384234 #14352]  INFO -- : ==========================================================
    I, [2014-10-23T18:10:31.384289 #14352]  INFO -- : upgrade
    I, [2014-10-23T18:10:31.384391 #14352]  INFO -- : ..load:defaults 0s
    I, [2014-10-23T18:10:31.384437 #14352]  INFO -- : ..rbenv:validate 0s
    I, [2014-10-23T18:10:31.384474 #14352]  INFO -- : ..rbenv:map_bins 0s
    I, [2014-10-23T18:10:31.384510 #14352]  INFO -- : ..bundler:map_bins 0s
    I, [2014-10-23T18:10:31.384576 #14352]  INFO -- : ..deploy:set_rails_env 0s
    I, [2014-10-23T18:10:31.384611 #14352]  INFO -- : upgrade 0s
    I, [2014-10-23T18:10:31.384636 #14352]  INFO -- : deploy
    I, [2014-10-23T18:10:31.384658 #14352]  INFO -- : ..deploy:starting
    I, [2014-10-23T18:10:31.384681 #14352]  INFO -- : ....deploy:check
    I, [2014-10-23T18:10:31.384715 #14352]  INFO -- : ......deploy:check:directories 0s
    I, [2014-10-23T18:10:31.384780 #14352]  INFO -- : ......deploy:check:linked_dirs 0s
    I, [2014-10-23T18:10:31.384819 #14352]  INFO -- : ......deploy:check:make_linked_dirs 0s
    I, [2014-10-23T18:10:31.384856 #14352]  INFO -- : ......deploy:check:linked_files 0s
    I, [2014-10-23T18:10:31.384888 #14352]  INFO -- : ....deploy:check 1s
    I, [2014-10-23T18:10:31.384924 #14352]  INFO -- : ....deploy:set_previous_revision 0s
    I, [2014-10-23T18:10:31.384957 #14352]  INFO -- : ..deploy:starting 1s
    I, [2014-10-23T18:10:31.385020 #14352]  INFO -- : ..deploy:started 0s
    I, [2014-10-23T18:10:31.385058 #14352]  INFO -- : ..deploy:new_release_path 0s
    I, [2014-10-23T18:10:31.385084 #14352]  INFO -- : ..deploy:updating
    I, [2014-10-23T18:10:31.385148 #14352]  INFO -- : ....deploy:set_current_revision 0s
    I, [2014-10-23T18:10:31.385176 #14352]  INFO -- : ....deploy:symlink:shared
    I, [2014-10-23T18:10:31.385210 #14352]  INFO -- : ......deploy:symlink:linked_files 0s
    I, [2014-10-23T18:10:31.385247 #14352]  INFO -- : ......deploy:symlink:linked_dirs 1s
    I, [2014-10-23T18:10:31.385283 #14352]  INFO -- : ....deploy:symlink:shared 1s
    I, [2014-10-23T18:10:31.385315 #14352]  INFO -- : ..deploy:updating 3s
    I, [2014-10-23T18:10:31.385378 #14352]  INFO -- : ..bundler:install 0s
    I, [2014-10-23T18:10:31.385403 #14352]  INFO -- : ..deploy:updated
    I, [2014-10-23T18:10:31.385426 #14352]  INFO -- : ....deploy:compile_assets
    I, [2014-10-23T18:10:31.385467 #14352]  INFO -- : ......deploy:assets:precompile 48s
    I, [2014-10-23T18:10:31.385504 #14352]  INFO -- : ......deploy:assets:backup_manifest 0s
    I, [2014-10-23T18:10:31.385536 #14352]  INFO -- : ....deploy:compile_assets 48s
    I, [2014-10-23T18:10:31.385587 #14352]  INFO -- : ....deploy:normalize_assets 0s
    I, [2014-10-23T18:10:31.385623 #14352]  INFO -- : ....deploy:migrate 23s
    I, [2014-10-23T18:10:31.385657 #14352]  INFO -- : ....whenever:update_crontab 1s
    I, [2014-10-23T18:10:31.385690 #14352]  INFO -- : ..deploy:updated 73s
    I, [2014-10-23T18:10:31.385728 #14352]  INFO -- : ..deploy:copy_config 0s
    I, [2014-10-23T18:10:31.385753 #14352]  INFO -- : ..deploy:publishing
    I, [2014-10-23T18:10:31.385796 #14352]  INFO -- : ....deploy:symlink:release 0s
    I, [2014-10-23T18:10:31.385829 #14352]  INFO -- : ..deploy:publishing 0s
    I, [2014-10-23T18:10:31.385867 #14352]  INFO -- : ..deploy:restart 10s
    I, [2014-10-23T18:10:31.385911 #14352]  INFO -- : ..deploy:generate_error_pages 5s
    I, [2014-10-23T18:10:31.385945 #14352]  INFO -- : ..delayed_job:restart 8s
    I, [2014-10-23T18:10:31.385994 #14352]  INFO -- : ..deploy:published 0s
    I, [2014-10-23T18:10:31.386019 #14352]  INFO -- : ..deploy:finishing
    I, [2014-10-23T18:10:31.386052 #14352]  INFO -- : ....deploy:cleanup 0s
    I, [2014-10-23T18:10:31.386083 #14352]  INFO -- : ..deploy:finishing 0s
    I, [2014-10-23T18:10:31.386107 #14352]  INFO -- : ..deploy:finished
    I, [2014-10-23T18:10:31.386142 #14352]  INFO -- : ....deploy:log_revision 0s
    I, [2014-10-23T18:10:31.386192 #14352]  INFO -- : ..deploy:finished 0s
    I, [2014-10-23T18:10:31.386225 #14352]  INFO -- : deploy 104s
    I, [2014-10-23T18:10:31.386246 #14352]  INFO -- : ==========================================================

### Settings
You could change threshold time to change the results duration's color.

```ruby
set :alert_threshold, 10              # default 60 sec
set :warning_threshold, 5             # default 30 sec
set :measure_error_handling, :raise   # default :silent
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-measure/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

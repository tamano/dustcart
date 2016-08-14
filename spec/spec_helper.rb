$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dustcart'

require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/spec/'
  track_files '{exe,lib}/**/*.rb'
end

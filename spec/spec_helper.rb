require 'bundler'
Bundler.require :default, :test
require 'splitter'

RSpec.configure do |config|
  config.before do
  end
end

def fixture_path(filename)
  File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
end

def fixture_file(filename)
  file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
  File.read(file_path)
end
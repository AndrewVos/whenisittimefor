ENV['RACK_ENV'] = 'test'
require 'application'
require 'rspec'
require 'rack/test'
require 'date'

$: << File.expand_path("../lib")
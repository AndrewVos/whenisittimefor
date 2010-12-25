require 'rubygems'
require 'sinatra/base'
require 'date-casually'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
  get '/?' do
    end_date = DateTime.new(2011, 6, 14)
    time_left = end_date.casual(:as => [:days, :months])
    erb :index, :locals => {:time_left => time_left }
  end
end

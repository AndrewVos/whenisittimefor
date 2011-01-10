require 'rubygems'
require 'sinatra/base'
require 'date-casually'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
  get '/?' do
    date_string = request.cookies["date"]
    if date_string
      date = DateTime.parse(date_string)
      time_left = date.casual(:as => [:days, :months])
      erb :index, :locals => {:time_left => time_left }
    else
      erb :enter_date
    end
  end
end

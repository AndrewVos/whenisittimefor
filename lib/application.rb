require 'rubygems'
require 'sinatra/base'
require 'date-casually'
require 'chronic'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
  get '/?' do
    date = Date.parse(request.cookies["date"]) rescue nil

    if date
      time_left = date.casual(:as => [:days, :months])
      erb :index, :locals => {:time_left => time_left }
    else
      erb :enter_date
    end
  end

  post '/?' do
    date = Chronic.parse(params[:date])
    response.set_cookie "date", date.to_s
    erb :index, :locals => {:time_left => get_time_left(Date.parse(date.to_s)) }
  end

  def get_time_left(date)
    date.casual(:as => [:days, :months])
  end
end

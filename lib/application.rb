require 'rubygems'
require 'sinatra/base'
require 'date-casually'
require 'chronic'
require File.join(File.dirname(__FILE__), 'configuration.rb')

class Application < Sinatra::Base
  get '/?' do
    date_string = request.cookies["date"]
    date = Date.parse(date_string) rescue nil

    if date
      time_left = get_time_left(date)
      erb :index, :locals => {:time_left => time_left }
    else
      erb :enter_date
    end
  end

  post '/?' do
    time = Chronic.parse(params[:date]) rescue nil
    if time
      date = time.to_date
      response.set_cookie "date", date.to_s
      erb :index, :locals => {:time_left => get_time_left(date) }
    else
      response.delete_cookie "date"
      erb :enter_date
    end
  end

  def get_time_left(date)
    date.casual(:as => [:days, :months])
  end
end

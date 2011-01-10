require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Application do
  include Rack::Test::Methods

  def app
    Application
  end

  context "GET /" do
    context "cookie does not contain a date" do
      it "should show the date input form" do
        get '/'
        expected_response_body = app.new.erb :enter_date
        last_response.body.should include expected_response_body
      end
    end
    context "cookie contains a date" do
      it "should show the time left formatted" do
        set_cookie "date=#{Date.today + 1}"
        get '/'
        last_response.body.should include "tomorrow"
      end
    end
  end
  context "POST /" do
    it "sets the users cookie" do
      post "/", { :date => "today" }
      get "/"
      expected_date = DateTime.new(Date.today.year, Date.today.month, Date.today.day)
      last_request.cookies["date"].should == Chronic.parse("today").to_s
    end
    it "should show the time left formatted" do
      post "/", { :date => "today" }
      last_response.body.should include "today"
    end
  end
end

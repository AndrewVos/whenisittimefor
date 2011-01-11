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
    context "with a date" do
      before :each do
        post '/', { :date => "today" }
      end
      it "sets the users cookie" do
        get '/'
        expected_cookie = Chronic.parse("today").to_date.to_s
        last_request.cookies["date"].should == expected_cookie
      end
      it "should show the time left formatted" do
        last_response.body.should include "today"
      end
    end
    context "without a date" do
      it "deletes the users cookie" do
        post '/', { :date => "today" }
        post '/'
        get '/'
        last_request.cookies["date"].should == nil
      end
      it "should show the date input form" do
        post '/'
        expected_response_body = app.new.erb :enter_date
        last_response.body.should include expected_response_body
      end
    end
  end
end

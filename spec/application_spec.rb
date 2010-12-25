require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Application do
  include Rack::Test::Methods

  def app
    Application
  end

  context "GET /" do
    it "should not 404" do
      get "/"
      last_response.ok?.should == true
    end

     it "should show the time left formatted" do
       DateTime.stub!(:now).and_return(DateTime.new(2009, 10, 10))
       end_date = DateTime.new(2011, 6, 14)

       get '/'

       app.new do |erb_app|
         expected_response_body = erb_app.erb(:index)
         last_response.body.should include "5 minutes and 20 seconds"
       end
     end
  end
end

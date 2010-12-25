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
       Date.stub!(:today).and_return(DateTime.new(2011, 6, 1))
       get '/'
       last_response.body.should include "less than a month from now"
     end
  end
end

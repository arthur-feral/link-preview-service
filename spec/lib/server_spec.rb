require 'spec_helper'

page_1 = read_file(File.dirname(__FILE__), '../support/', 'page_1.html')

def app
  LinkSnifferServer.new
end

describe LinkSnifferServer do
  let(:response_page_1){
    response = {
      image: "",
      title: "",
      description: ""
    }.to_json
    response
  }
  describe "GET '/'" do
    before(:each) do
      stub_request(:get, /http:\/\/www.bringr.com/).
        to_return(status: 200, body: page_1)
    end
    context "response ok" do
      it "returns 200" do
        get '/', { url: "http://www.bringr.com" }
        # expect(last_response).to be_ok
        expect(last_response.status).to eq 200
        # expect(last_response.body).to eq response_page_1
      end
    end
  end
end

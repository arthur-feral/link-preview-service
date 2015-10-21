require 'spec_helper'

page_1 = read_file(File.dirname(__FILE__), '../support/', 'page_1.html')

def app
  LinkSnifferServer.new
end

describe LinkSnifferServer do
  let(:response_page_1){
    response = {
      images: ["http://www.iadvize.com/fr/wp-content/uploads/sites/2/2015/07/iadvize-logo.png"],
      title: "iAdvize : plateforme d'engagement client en temps réel.",
      description: "Engagez vos visiteurs en temps réel par Click to Chat, Click to Call, Click to Video et click to Community depuis votre site et les réseaux sociaux !"
    }.to_json
    response
  }
  describe "GET '/'" do
    before(:each) do
      stub_request(:get, /http:\/\/www.iadvize.com/).
        to_return(status: 200, body: page_1)
    end
    context "All parameters ok" do
      it "returns 200" do
        get '/', { url: "http://www.iadvize.com/?lang=fr" }
        # expect(last_response).to be_ok
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq response_page_1
      end
    end

    context "parameters missing" do
      it "returns 400" do
        get '/'
        expect(last_response.status).to eq 400
        expect(last_response.body).to eq ""
      end
    end
  end
end

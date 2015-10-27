require 'spec_helper'

page_1 = read_file(File.dirname(__FILE__), '../support/', 'page_1.html')

def app
  LinkSnifferServer.new
end

describe LinkSnifferServer do
  let(:response_page_1){
    response = {
      url: "http://www.iadvize.com/?lang=fr",
      images: ["http://www.iadvize.com/fr/wp-content/uploads/sites/2/2015/07/iadvize-logo.png"],
      title: "iAdvize : plateforme d'engagement client en temps réel.",
      description: "Engagez vos visiteurs en temps réel par Click to Chat, Click to Call, Click to Video et click to Community depuis votre site et les réseaux sociaux !"
    }.to_json
    response
  }
  describe "GET '/'" do
    context "httpclient returns success" do
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

    context "httpclient returns error" do
      describe 'too many redirects' do
        before do
          stub_request(:get, /http:\/\/www.iadvize.com/).
            to_return(status: 310, body: '')
        end

        it "returns 404" do
          get '/', { url: "http://www.iadvize.com/?lang=fr" }
          expect(last_response.status).to eq 404
        end
      end

      describe 'not found' do
        before do
          stub_request(:get, /http:\/\/www.iadvize.com/).
            to_return(status: 404, body: '')
        end

        it "returns 404" do
          get '/', { url: "http://www.iadvize.com/?lang=fr" }
          expect(last_response.status).to eq 404
        end
      end

      describe 'Error' do
        before do
          stub_request(:get, /http:\/\/www.iadvize.com/).
            to_return(status: 500, body: '')
        end

        it "returns 404" do
          get '/', { url: "http://www.iadvize." }
          expect(last_response.status).to eq 404
        end
      end
    end
  end
end

require 'spec_helper'

# Html page containg all required og metadatas
page_1 = read_file(File.dirname(__FILE__), '../support/', 'page_1.html')

# Html page containg partial og metadatas (missing og:title)
page_2 = read_file(File.dirname(__FILE__), '../support/', 'page_2.html')

# Html page containg partial og metadatas (missing og:description)
page_3 = read_file(File.dirname(__FILE__), '../support/', 'page_3.html')

# Html page containg partial og metadatas (missing og:image)
page_4 = read_file(File.dirname(__FILE__), '../support/', 'page_4.html')

describe HtmlParser do
  context "Page contains OG metadatas" do
    let(:parser){HtmlParser.new}
    let(:result_page_1){
      datas = {
        images: ["http://www.iadvize.com/fr/wp-content/uploads/sites/2/2015/07/iadvize-logo.png"],
        title: "iAdvize : plateforme d'engagement client en temps réel.",
        description: "Engagez vos visiteurs en temps réel par Click to Chat, Click to Call, Click to Video et click to Community depuis votre site et les réseaux sociaux !"
      }
      datas
    }

    let(:result_page_2){
      datas = {
        images: ["http://www.iadvize.com/fr/wp-content/uploads/sites/2/2015/07/iadvize-logo.png"],
        title: "Un titre de secours",
        description: "Engagez vos visiteurs en temps réel par Click to Chat, Click to Call, Click to Video et click to Community depuis votre site et les réseaux sociaux !"
      }
      datas
    }

    let(:result_page_3){
      datas = {
        images: ["http://www.iadvize.com/fr/wp-content/uploads/sites/2/2015/07/iadvize-logo.png"],
        title: "iAdvize : plateforme d'engagement client en temps réel.",
        description: ""
      }
      datas
    }

    let(:result_page_4){
      datas = {
        images: [
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/images/logo-iadvize.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/images/logo-iadvize-sticky.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/videos/home/no-video-image.jpg",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/videos/home/mob-video-image.jpg",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/logo-lacoste-300x150.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/logo-bmw-300x150.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/boursorama-logo-300x150.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/logo-rdc.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/medias/test/cooktoys-social.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/medias/test/cooktoys-website.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/medias/test/advisor-mobile.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/medias/test/community-mobile.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/images/home/play-button.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/fnac-logo.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/maisons-du-monde-logo.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/pierre-et-vacances-logo.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/images/home/play-button.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/logo-total-mini.png",
          "http://www.iadvize.com/fr/wp-content/themes/iAdvizeV3/library/images/home/play-button.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/numericable-logo.png",
          "http://d2t5zic2rt51h6.cloudfront.net/wp-content/uploads/sites/2/2015/04/airfrance-logo.png",
          "//static.iadvize.com/images/livechat/iadvizev2/FR-btn-chat.png",
          "//static.iadvize.com/images/livechat/iadvizev2/FR-btn-call.png",
          "//static.iadvize.com/images/livechat/iadvizev2/FR-btn-idz-iadvizev2-chat-call-beatriz.png",
          "http://static.iadvize.com/images/livechat/blank.gif"
        ],
        title: "iAdvize : plateforme d'engagement client en temps réel.",
        description: "Engagez vos visiteurs en temps réel par Click to Chat, Click to Call, Click to Video et click to Community depuis votre site et les réseaux sociaux !"
      }
      datas
    }

    it "parse correctly the page" do
      parser.parse(page_1)
      expect(parser.getOGDatas).to eq result_page_1
    end

    it "returns OG datas" do
      
    end
  end

  context "Page contains partials OG metadatas" do
    context "missing og:image" do
      context "Page contains images" do

      end
      context "Page doesn't contain images" do

      end
    end

    context "missing og:title" do
      context "Page contains title tag" do

      end
      context "Page doesn't contain title tag" do

      end
    end

    context "missing og:description" do

    end
  end
end
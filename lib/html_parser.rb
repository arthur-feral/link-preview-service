require 'nokogiri'

class HtmlParser
  def initialize
    @OGDatas = {images: [], title: "", description: ""}
    @doc = nil
    @logger = getLogger
  end

  def parse(html = '')
    begin
      @doc = Nokogiri::HTML(html)
      binding.pry
      @OGDatas[:title] = self.findTitle
      @OGDatas[:images] = self.findImages
      @OGDatas[:description] = self.findDescription
    rescue StandardError => e
      @logger.error('Parser'){ "Error while parsing html document" }
      @logger.error('Parser'){ "#{e}" }
    end
  end

  def findTitle
    title = ''
    return title if @doc.nil?
    begin
      metaTitles = @doc.css('meta[property="og:title"]')
      if metaTitles.count != 0
        if metaTitles.first.attributes.has_key?('content')
          return metaTitles.first.attributes['content'].value
        end
      end

      pageTitles = @doc.css('title')
      if pageTitles.count != 0
        return @doc.css('title').first.text
      end
    rescue StandardError => e
      return title
    end

    return title
  end

  def findImages
    images = []
    return images if @doc.nil?
    begin
      metaImage = @doc.cs('meta[property="og:image"]')
      if metaImage.count != 0
        if metaImage.first.attributes.has_key?('content')
          return metaImage.first.attributes['content'].value
        end
      end

    rescue StandardError => e
      return images
    end

    return images
  end

  def findDescription
    description = ''
    return description if @doc.nil?
    begin
      metaDescription = @doc.css('meta[property="og:description"]')
      if metaDescription.count != 0
        if metaDescription.first.attributes.has_key?('content')
          return metaDescription.first.attributes['content'].value
        end
      end

      pageDescription = @doc.css('meta[name="description"]')
      if pageDescription.count != 0
        if metaDescription.first.attributes.has_key?('content')
          return pageDescription.first.attributes["content"].value
        end
      end
    rescue StandardError => e
      return description
    end

    return description
  end

  def getOGDatas
    return @OGDatas
  end
end
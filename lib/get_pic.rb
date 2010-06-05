require "open-uri"
require "uri"

module GetPic
  
  def self.get(link)
    doc = Nokogiri::HTML(open(URI.escape(link)))
    pics = doc.css('img').map do |img|
      if img['src']
        img['src'] if img['src'].match(/.jpg$/)
      end
    end
    pics.compact!
    
    # pixmania
    pics = pics.reject{|pic| pic.match(/logos|amex|paypal|carteVIPIX|\.ad\?/) }
    return pics
  end
  
end
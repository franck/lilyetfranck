require "open-uri"
require "get_pic"

class GiftsController < ApplicationController
  
  before_filter :get_top_page_photos
  
  def index
    @gifts = Gift.all
  end
  
  def new
    @gift = Gift.new
  end
  
  def create
    @gift = Gift.new(params[:gift])
    if @gift.save
      redirect_to edit_pic_gift_path(@gift)
    else
      render :new
    end
  end
  
  def edit_pic
    @gift = Gift.find(params[:id])
    host = URI.parse(@gift.link).host   
    doc = Nokogiri::HTML(open(URI.escape(@gift.link)))
    @pics = doc.css('img').map do |img|
      if img['src']
        src = img['src'] if img['src'].match(/.jpg/)
        logger.debug("SRC : #{src}")
        if src && !src.blank?
          unless src.match(/^http/)
            if src.match(/^\//)
              src = "http://#{host}#{src}"
            else
              src = "http://#{host}/#{src}"
            end
          end
        end
      end
      src
    end
    @pics << "http://#{APP_CONFIG[:domain]}/images/gift_bw.png"
    @pics.compact!
  end
  
  def update_pic
    @gift = Gift.find(params[:id])
    @gift.pic = CGI::unescape(params[:pic])
    @gift.save
    redirect_to gifts_path()
  end
  
  def edit
    @gift = Gift.find(params[:id])
  end
  
  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(params[:gift])
      redirect_to edit_pic_gift_path(@gift)
    else
      render :edit
    end
  end
  
  def destroy
    gift = Gift.find(params[:id])
    gift.destroy
    redirect_to gifts_url
  end
  
end

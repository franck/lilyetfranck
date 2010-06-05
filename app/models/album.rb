class Album < ActiveRecord::Base
  
  def photoset(args={})
    options = {
      :extras => "tags, url_sq, url_m"
    }.merge args
    options[:photoset_id] = self.photoset_id
    flickr.photosets.getPhotos(options)
  end
  
  def photoset_info
    flickr.photosets.getInfo(:photoset_id => self.photoset_id)
  end
  
  def photos(args={})
    photoset(args).to_hash["photo"]
  end
  
  def self.random(number=3, args={})
    options = {
      :extras => "url_sq, url_t, url_s, url_m"
    }.merge args
    
    albums = Album.descend_by_created_at
    @random_photos = []
    
    albums.each do |album|
      photos = album.photos(options)
      
      if photos.size == 1
        @random_photos << photos.first
      elsif photos.size <= number
        @random_photos << photos
      else
        @random_photos << photos.sort_by{ rand }
      end
          
      @random_photos = @random_photos.flatten.first(number)
      return @random_photos if @random_photos.size == number
    end
  end
  
end

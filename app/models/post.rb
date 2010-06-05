class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
  has_friendly_id :title, :use_slug => true
  
  validates_presence_of :title, :message => "Le titre doit être rempli"
  
end

class Gift < ActiveRecord::Base
  
  validates_presence_of :name, :message => "Il manque le nom du cadeau"
  validates_presence_of :link, :message => "Il manque le lien vers le site marchand"
  validates_presence_of :price, :message => "Il manque le prix"
  
end

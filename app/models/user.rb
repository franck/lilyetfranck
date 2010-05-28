class User < ActiveRecord::Base
  
  has_friendly_id :name, :use_slug => true
  
  acts_as_authorization_subject
  acts_as_authentic do |c|
    c.login_field = :email
    c.logged_in_timeout = 2.weeks
    c.perishable_token_valid_for = 2.hours
    
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    
    
    c.validate_login_field(false)
    
    c.validates_length_of_email_field_options = {
      :within => 6..100,
      :message => I18n.t('users.error_messages.email_length') 
    }
    c.validates_format_of_email_field_options = {
      :with => Authlogic::Regex.email,
      :message => I18n.t('users.error_messages.email_format')
    }
    c.validates_uniqueness_of_email_field_options = {
      :message => I18n.t('users.error_messages.email_uniqueness')
    }
    c.validates_length_of_password_field_options = { 
      :minimum => 4, 
      :on => :update, 
      :if => :require_password?,
      :message => I18n.t('users.error_messages.password_length')
    }
    c.validates_length_of_password_confirmation_field_options = { 
      :minimum => 4,
      :on => :update, 
      :if => :require_password?,
      :message => I18n.t('users.error_messages.password_confirmation_length')
    }
    c.validates_confirmation_of_password_field_options = {
      :minimum => 4, 
      :if => :require_password?,
      :message => I18n.t('users.error_messages.confirmation_of_password_field')
    }
  end
  
  validates_presence_of :firstname
  validates_presence_of :lastname
  
  def name
    "#{firstname} #{lastname}"
  end
  
  def roles
    self.role_objects.map(&:name).join(", ")
  end  
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper :layout
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  rescue_from Acl9::AccessDenied, :with => :access_denied

  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :authenticate

  private
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "crevette" && password == "crevette"
    end
  end
  
  # PUBLIC
  
  def get_top_page_photos
    @top_photos = Album.random(3)
    #@top_photos = flickr.photosets.getPhotos(:photoset_id => "72157624153769016", :extras => "tags, url_sq")
  end
  
  # ADMIN
  
  # def default_url_options(options={})  
  #     { :locale => I18n.locale }
  #   end
  
  def access_denied
    flash[:error] = t('authlogic.flash.access_denied')
    redirect_back_or_default login_url
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def user_is_current_user?
    if @user
      @user == @current_user
    else
      true
    end
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = t('authlogic.flash.require_user')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

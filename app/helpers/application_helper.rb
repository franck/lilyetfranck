# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers
  
  access_control :show_admin_or_current_user? do
    allow "admin"
    allow "user", :if => :user_is_current_user?
  end
  
  access_control :show_admin? do
    allow "admin"
  end
  
  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end
end

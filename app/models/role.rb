class Role < ActiveRecord::Base
  ROLES = ["admin", "user"]
  acts_as_authorization_role
end

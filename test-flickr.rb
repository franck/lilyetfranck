require 'rubygems'
require 'flickraw'

FlickRaw.api_key="cd748dfc0571d013448e0453772dcea7"
FlickRaw.shared_secret="b947f50967104323"

frob = flickr.auth.getFrob
auth_url = FlickRaw.auth_url :frob => frob, :perms => 'read'

puts "Open this url in your process to complete the authication process : #{auth_url}"
puts "Press Enter when you are finished."
STDIN.getc

begin
  auth = flickr.auth.getToken :frob => frob
  login = flickr.test.login
  puts "You are now authenticated as #{login.username} with token #{auth.token}"
rescue FlickRaw::FailedResponse => e
  puts "Authentication failed : #{e.msg}"
end
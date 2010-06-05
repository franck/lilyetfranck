raw_config = File.read(RAILS_ROOT + "/config/flickr.yml")
FLICKR = YAML.load(raw_config).symbolize_keys
FlickRaw.api_key = FLICKR[:key]
FlickRaw.shared_secret = FLICKR[:secret]
@auth = flickr.auth.checkToken :auth_token => FLICKR[:token]
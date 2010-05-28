# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lilyetfranck_session',
  :secret      => 'ccfcf58e0723b7d27aeb03c969144f3b38c1b479c32d8a7e6c24e5b406c4adacf8fa10be7fc22740ec8f1e551307f04371640b0504f57a271aa9dc0eb3ccd66a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

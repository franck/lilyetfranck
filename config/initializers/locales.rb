I18n.backend = Globalize::Backend::Static.new
I18n.load_path += Dir.glob("config/locales/*.yml")
["fr", "de", "en"].each{|locale| I18n.load_path += Dir.glob("config/locales/#{locale}/*.yml") }
I18n.default_locale = "fr"
I18n.fallbacks[:fr] = "fr"
I18n.fallbacks[:en] = "en"
I18n.fallbacks[:de] = "de"
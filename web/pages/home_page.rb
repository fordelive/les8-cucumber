class HomePage < Howitzer::Web::Page
  path '/'
  validate :url, %r{\A(?:.*?:\/\/)?[^\/]*\/?\z}

  section :menu
end

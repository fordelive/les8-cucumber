class LoginPage < Howitzer::Web::Page
  path 'users/sign_in'
  validate :title, /Demo web application - Login form\z/
end
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

Dir[
  './emails/**/*.rb',
  './web/sections/**/*.rb',
  './web/pages/**/*.rb',
  './prerequisites/models/**/*.rb',
  './prerequisites/factory_bot.rb'
].each { |f| require f }

String.send(:include, Howitzer::Utils::StringExtensions)

CORRECT_LOGIN = app_test_user
CORRECT_PASSWORD = app_test_pass

INCORRECT_LOGIN = 'blabla@mail.net'
INCORRECT_PASSWORD = '123456'
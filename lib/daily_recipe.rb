#environment
require 'open-uri'
require 'nokogiri' # add dependency to gemspec
require 'pry'
require 'terminal-table'


require_relative "daily_recipe/version"
require_relative './daily_recipe/cli'
require_relative './daily_recipe/recipe'

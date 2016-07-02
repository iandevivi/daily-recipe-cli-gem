# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daily_recipe/version'

Gem::Specification.new do |spec|
  spec.name          = "daily_recipe"
  spec.version       = DailyRecipe::VERSION
  spec.authors       = ["Ian DeVivi"]
  spec.email         = ["iandevivi@gmail.com"]

  spec.summary       = "Daily Recipes List"
  spec.description   = "List of recipes with ratings and cooking time, along with ingredient list and cooking instructions."
  spec.homepage      = "https://github.com/iandevivi/daily-recipe-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["daily_recipe"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
  spec.add_dependency "terminal-table"
end

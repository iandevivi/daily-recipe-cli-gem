require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

class Recipe

  attr_accessor :name, :rating, :url, :api_id

  @@recipes = []

  BASE_URL = "http://www.foodnetwork.com"

  def self.all
    @@recipes
  end

  def self.scrape_food_network
    start_time = Time.now
    html = Nokogiri::HTML(open("http://www.foodnetwork.com/recipes/photos/recipe-of-the-day-what-to-cook-now.html"))

    featured_recipes = html.css("li.get-more-item")
    featured_recipes.each do |r|

      recipe = Recipe.new
      recipe.name = r.css("h6 a").text
      recipe.url = BASE_URL + r.css("h6 a").attribute("href").value
      recipe.api_id = (r.css("a.community-rating-stars").attribute("data-rating").value).scan(/\w+\-.+\w+/).join("-")
      recipe.rating = Recipe.get_rating(recipe.api_id)
      @@recipes << recipe
    end
    end_time = Time.now
    elapsed_time = start_time - end_time

    self.all
  end

  def self.get_rating(api_id)
    gigya_api_url = "http://comments.us1.gigya.com/comments.getStreamInfo?categoryID=recipe&streamID=API_ID&includeRatingDetails=true&APIKey=3_ClDcX23A7tU8pcydnKyENXSYP5kxCbwH4ZO741ZOujPRY8Ksj2UBnj8Zopb0OX0K&sdk=js_6.3.02&format=jsonp&callback=gigya._.apiAdapters.web.callback"
    api_id_url = gigya_api_url.gsub("API_ID", api_id)
    recipe_json = Nokogiri::HTML(open(api_id_url))
    part1 = recipe_json.text.gsub("gigya._.apiAdapters.web.callback(","")
    part2 = part1.gsub("});","}")
    parsed = JSON.parse(part2, symbolize_names: true)
    binding.pry
    rating = parsed[:streamInfo][:avgRatings][:_overall]
    rating
  end

end

Recipe.scrape_food_network

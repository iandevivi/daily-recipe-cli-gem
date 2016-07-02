require 'json'
class DailyRecipe::Recipe

  attr_accessor :name, :cook_time, :rating, :api_id, :url
  BASE_URL = "http://www.foodnetwork.com"
  def self.today
    self.scrape_food_network
  end

  def self.scrape_food_network
    recipes = []
    doc = Nokogiri::HTML(open("http://www.foodnetwork.com/recipes/photos/recipe-of-the-day-what-to-cook-now.html"))
    doc.search(".feed li").each do |x|
      recipe = self.new
      recipe.name = x.search("h6 a").text
      recipe.cook_time = x.search("dd").text
      recipe.api_id = (x.css("a.community-rating-stars").attribute("data-rating").value).scan(/\w+\-.+\w+/).join("-")
      recipe.url = BASE_URL + x.search(".community-rating-stars").attribute("href").value
      recipe.rating = get_rating(recipe.api_id)
      recipes << recipe
    end
    recipes
  end

  def self.get_rating(api_id) #@beingy is the man
    gigya_api_url = "http://comments.us1.gigya.com/comments.getStreamInfo?categoryID=recipe&streamID=API_ID&includeRatingDetails=true&APIKey=3_ClDcX23A7tU8pcydnKyENXSYP5kxCbwH4ZO741ZOujPRY8Ksj2UBnj8Zopb0OX0K&sdk=js_6.3.02&format=jsonp&callback=gigya._.apiAdapters.web.callback"
    api_id_url = gigya_api_url.gsub("API_ID", api_id)
    recipe_json = Nokogiri::HTML(open(api_id_url))
    part1 = recipe_json.text.gsub("gigya._.apiAdapters.web.callback(","")
    part2 = part1.gsub("});","}")
    parsed = JSON.parse(part2, symbolize_names: true)
    rating = parsed[:streamInfo][:avgRatings][:_overall]
    rating
  end  #Parses JSON to get access to the gigya API info in order to scrape the ratings information.  

  def self.scrape_full_recipe(the_recipe)

    doc = Nokogiri::HTML(open(the_recipe.url))
    ingredients = doc.search("div.ingredients li")
    puts ""
    puts "Ingredients"
    ingredients.each do |ingredient|
      puts ingredient.text
    end

    cooking_instructions = doc.search("div.directions li")
    cooking_instructions.each do |instruction|
      puts ""
      puts instruction.text
    end
  end



end

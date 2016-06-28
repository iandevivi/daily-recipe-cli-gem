class DailyRecipe::Recipe

  attr_accessor :name, :cook_time, :rating, :reviews, :url

  def self.today
    #scrape foodnetwork for all recipes
    self.scrape_recipes
  end


  def self.scrape_recipes
    recipes = []

    recipes << self.scrape_food_network

    # Go to foodnetwork, find recipes
    # extract properties
    # instantiate the recipes


    # recipe_1 = self.new
    # recipe_1.name = "Herb Chicken"
    # recipe_1.cook_time = "1 hour 30 minutes"
    # recipe_1.rating = "4.5/5"
    # recipe_1.reviews = "16"
    # recipe_1.url = "http://www.foodnetwork.com/recipes/food-network-kitchens/herb-roasted-chicken-with-melted-tomatoes-recipe.html"
    #
    # recipe_2 = self.new
    # recipe_2.name = "Guacamole"
    # recipe_2.cook_time = "fast"
    # recipe_2.rating = "5/5"
    # recipe_2.reviews = "783"
    # recipe_2.url = "http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe.html"
    # [recipe_1, recipe_2]
    recipes
  end

  def self.scrape_food_network
    doc = Nokogiri::HTML(open("http://www.foodnetwork.com/recipes/photos/recipe-of-the-day-what-to-cook-now.html"))
    binding.pry

    doc.search(".feed li").each do |x|

      # name = doc.search("h6 a").text
      # cook_time = doc.search("li dd").text
      # url = doc.search(".community-rating-stars").attribute("href").value
    #  rating =
    end

  end

end

class DailyRecipe::Recipe

  attr_accessor :name, :cook_time, :rating, :reviews, :url

  def self.today
    self.scrape_food_network
  end


  # def self.scrape_recipes
  #   self.scrape_food_network
  # end

  def self.scrape_food_network
    recipes = []
    doc = Nokogiri::HTML(open("http://www.foodnetwork.com/recipes/photos/recipe-of-the-day-what-to-cook-now.html"))
    doc.search(".feed li").each do |x|
      #binding.pry
      y = self.new
      y.name = x.search("h6 a").text
      y.cook_time = x.search("dd").text
      y.url = x.search(".community-rating-stars").attribute("href").value
      y.rating = "  5/7  "
      recipes << y
    end
    recipes
  end

  def self.scrape_full_recipe(the_recipe)

    doc = Nokogiri::HTML(open("http://www.foodnetwork.com"+the_recipe.url))
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
    #ingredients.each {|ingredient| puts ingredient}
    #cooking_instructions.each {|p| puts p}
  end



end

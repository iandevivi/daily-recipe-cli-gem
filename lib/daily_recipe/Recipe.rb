class DailyRecipe::Recipe

  attr_accessor :name, :cook_time, :rating, :reviews, :url

  def self.today
    self.scrape_recipes
  end


  def self.scrape_recipes
    self.scrape_food_network
  end

  def self.scrape_food_network
    recipes = []
    doc = Nokogiri::HTML(open("http://www.foodnetwork.com/recipes/photos/recipe-of-the-day-what-to-cook-now.html"))
    doc.search(".feed li").each do |x|
      #binding.pry
      y = self.new
      y.name = x.search("h6 a").text
      y.cook_time = x.search("dd").text
      y.url = x.search(".community-rating-stars").attribute("href").value
      y.rating = "5/7.  9/10 with rice"
      recipes << y
    end
    recipes
  end

    

end

#our CLI controller

class DailyRecipe::CLI

  def call
    puts "Here are today's Daily Recipes"
    list_recipes
    menu
  end

  def list_recipes
    #will get recipes
    @recipes = DailyRecipe::Recipe.today
    puts "    Recipe name     Rating      Cooking Time"
    @recipes.each.with_index(1) do |recipe, i|  #There is a Recipe class with a #today method for today's recipes

      puts "#{i}. #{recipe.name} - #{recipe.rating} - #{recipe.cook_time}"
    end
  end

  def menu

    input = nil
    while input != "exit"
      puts "Enter the number of the recipe you would like to explore."
      puts "Enter list to see the full list of recipes."
      puts "Type exit to exit"
      input = gets.strip.downcase

      if input.to_i > 0
        the_recipe = @recipes[input.to_i-1]
        puts "#{the_recipe.name} - #{the_recipe.rating} - #{the_recipe.cook_time}"
        #clear #provide more information about the recipe 
      elsif input == "list"
        list_recipes
      elsif input == "exit"
        goodbye
      else
        puts "Not sure what you are asking for, type list or exit."
      end

    end
  end

  def goodbye
    puts "Please join us tomorrow for more amazing recipes!"
  end
end

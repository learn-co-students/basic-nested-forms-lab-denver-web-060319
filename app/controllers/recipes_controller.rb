class RecipesController < ApplicationController
  
  before_action :find_recipe, only: [:show]

  def show
  end

  def index
    if params[:search]
      @recipes = Recipe.where("title LIKE ?", "%#{params[:search]}%")
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.valid?
      @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, ingredients_attributes: [:name, :quantity])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end

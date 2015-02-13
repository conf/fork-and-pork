class MealsController < ApplicationController

  before_filter :authenticate_user!

  respond_to :json

  def index
    respond_with current_user.meals
  end

  def show
    respond_with current_user.meals.find(params[:id])
  end

  def create
    meal = current_user.meals.create(meal_params)
    respond_with meal
  end

  def update
    meal = current_user.meals.find(params[:id])
    meal.update(meal_params_for_update)
    respond_with meal
  end

  def destroy
    meal = current_user.meals.find(params[:id])
    meal.destroy
    respond_with meal
  end

  private

  def meal_params
    params.require(:meal).permit(:details, :calories, :user_id, :created_at)
  end

  def meal_params_for_update
    meal_params.except(:user_id)
  end

end

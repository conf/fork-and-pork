class MealsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_meal!, only: [:edit, :show, :update, :destroy]

  respond_to :js, :json

  def index
    respond_with current_user.meals
  end

  def new
    @meal = Meal.new(user: current_user)
    respond_with @meal
  end

  def show
    respond_with @meal
  end

  def edit
    respond_with @meal
  end

  def create
    @meal = current_user.meals.create(meal_params)
    respond_with @meal
  end

  def update
    @meal.update(meal_params_for_update)
    respond_with @meal
  end

  def destroy
    @meal.destroy
    respond_with @meal
  end

  private

  def find_meal!
    @meal = current_user.meals.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:details, :calories, :user_id, :created_at)
  end

  def meal_params_for_update
    meal_params.except(:user_id)
  end

end

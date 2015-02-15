class MealsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_meal!, only: [:edit, :show, :update, :destroy]

  respond_to :js, :json

  def index
    @meals = current_user.meals.filter_by_date(meals_filter_by_date_params).sorted
    respond_with @meals
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
    @meal.update(meal_params)
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
    params.require(:meal).permit(:details, :calories, :created_at)
  end

  def meals_filter_by_date_params
    params.require(:filter_meals).permit(:from, :to, :from_time, :to_time)
  end

end

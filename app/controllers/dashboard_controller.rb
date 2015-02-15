class DashboardController < ApplicationController

  def index
    @meals = current_user.meals.sorted
  end

end

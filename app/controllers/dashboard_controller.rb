class DashboardController < ApplicationController

  def index
    @meals = user_signed_in? ? current_user.meals.sorted : []
  end

end

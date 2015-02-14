class CaloriesController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json, :js

  def calories
    respond_with current_user
  end

  def update
    current_user.update(calories_params)
    flash.notice = 'Successfully updated calories!' unless current_user.errors.any?
    respond_with current_user
  end

  private

  def calories_params
    params.require(:user).permit(:calories)
  end

end

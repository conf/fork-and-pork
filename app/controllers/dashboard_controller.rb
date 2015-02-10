class DashboardController < ApplicationController

  def index
  end


  private

  # Devise helper functions, since we use Devise forms in non-devise controllers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[resource_name]
  end

  helper_method :resource_name, :resource, :devise_mapping
end

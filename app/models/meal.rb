class Meal < ActiveRecord::Base

  validates :details, :calories, :created_at, presence: true

end

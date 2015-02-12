class Meal < ActiveRecord::Base

  belongs_to :user

  validates :details, :calories, :created_at, presence: true

end

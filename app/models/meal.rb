class Meal < ActiveRecord::Base

  belongs_to :user

  validates :details, :calories, :created_at, presence: true
  validates :calories, numericality: { greater_than: 0 }

  before_validation :set_created_at

  def set_created_at
    self.created_at ||= Time.current
  end

  def same_day_meals
    user.meals.where('DATE(created_at) = ?', created_at.to_date).order(:created_at)
  end

  def diet?
    return true unless user.calories

    decorated_meals = MealDecorator.decorate_with_diet(same_day_meals)
    decorated_meals.detect { |meal| meal.id == id }.diet?
  end

end

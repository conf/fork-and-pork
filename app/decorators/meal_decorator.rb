class MealDecorator < SimpleDelegator

  attr_accessor :eaten_calories

  def initialize(base, eaten_calories)
    super(base)
    @eaten_calories = eaten_calories
  end

  def diet?
    return true unless user.calories
    eaten_calories < user.calories
  end

  def self.decorate_with_diet(collection)
    grouped = collection.group_by { |meal| "#{meal.user_id}_#{meal.created_at.to_date}" }
    grouped.map do |_, meals_per_user_per_date|
      eaten_calories_per_date = 0
      meals_per_user_per_date.sort_by(&:created_at).map do |meal|
        eaten_calories_per_date += meal.calories
        MealDecorator.new(meal, eaten_calories_per_date)
      end
    end.flatten
  end
end

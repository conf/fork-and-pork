class Meal < ActiveRecord::Base

  belongs_to :user

  validates :details, :calories, :created_at, presence: true
  validates :calories, numericality: { greater_than: 0 }

  before_validation :set_created_at

  def set_created_at
    self.created_at ||= Time.current
  end

end

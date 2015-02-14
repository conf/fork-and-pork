class User < ActiveRecord::Base

  has_many :meals, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :calories, numericality: { greater_than: 0 }, allow_nil: true
end

require 'rails_helper'

RSpec.describe Meal, type: :model do

  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:calories) }

  it { should belong_to(:user) }

  it { should validate_numericality_of(:calories).is_greater_than(0) }
end

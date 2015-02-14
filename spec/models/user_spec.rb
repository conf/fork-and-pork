require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of :email }
  it { should validate_numericality_of(:calories).is_greater_than(0) }

  it { should have_many(:meals) }
end

require 'rails_helper'

RSpec.describe Meal, type: :model do

  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:calories) }
  it { should validate_presence_of(:created_at) }

  it { should belong_to(:user) }
end

require 'rails_helper'

RSpec.describe Meal, type: :model do

  it { should validate_presence_of(:details) }
  it { should validate_presence_of(:calories) }

  it { should belong_to(:user) }

  it { should validate_numericality_of(:calories).is_greater_than(0) }

  context '#diet?' do
    let(:user) { FactoryGirl.create(:user, calories: calories) }

    context 'user has no calories settings' do
      let(:calories) { nil }
      it 'should be always diet' do
        meal  = FactoryGirl.create(:meal, user: user, calories: 10000)

        expect(meal).to be_diet
      end
    end

    context 'user has calories settings' do
      let(:calories) { 200 }

      it 'should be diet if user ate less her daily calories dose on that day' do
        meal1 = FactoryGirl.create(:meal, user: user, calories: 100)
        expect(meal1).to be_diet

        meal2 = FactoryGirl.create(:meal, user: user, calories: 200)
        expect(meal2).not_to be_diet
      end

      it 'should be diet even if user ate more on the next day' do
        meal1 = FactoryGirl.create(:meal, user: user, calories: 100)
        FactoryGirl.create(:meal, user: user, calories: 200, created_at: 1.day.from_now)
        expect(meal1).to be_diet
      end
    end
  end
end

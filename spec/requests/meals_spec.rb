require 'rails_helper'

RSpec.describe 'Meals', type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_meal) { FactoryGirl.build(:meal, user: user) }

  before do
    login(user)
  end

  describe 'json' do

    describe 'on creation' do
      it 'should return created meal on success' do
        post meals_path, format: :json, meal: valid_meal.attributes
        assert_response :success
        expect(json_response[:diet]).to be false
      end

      it 'should return errors on fail' do
        post meals_path, format: :json, meal: { calories: 100 }
        assert_response :unprocessable_entity
        expect(json_response).to have_key :errors
      end
    end


    describe 'information retrieval' do

      let!(:meals) { FactoryGirl.create_list(:meal, 3, user: user, calories: 100) }
      let(:meal) { meals.first }

      describe 'single meal' do
        it 'should get a single meal with diet attribute set' do
          get meal_path(meal), format: :json
          assert_response :success
          expect(json_response).to be_a(Hash)
          expect(json_response[:id]).to eq meal.id
          expect(json_response[:diet]).to be true
        end

        it 'should return 404 when no meal exists' do
          expect { get meal_path(id: -1), format: :json }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      describe 'on update' do
        it 'should update a meal on success' do
          updated_meal = { id: meal.id, details: 'Cucumber' }
          patch meal_path(meal), format: :json, meal: updated_meal
          assert_response :no_content
          expect(meal.reload.details).to eq 'Cucumber'
        end

        it 'should return errors on fail' do
          updated_meal = { id: meal.id, details: nil }
          patch meal_path(meal), format: :json, meal: updated_meal
          assert_response :unprocessable_entity
          expect(json_response).to have_key :errors
        end
      end

      it 'should destroy a meal' do
        delete meal_path(meal), format: :json
        assert_response :no_content
        expect { meal.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    describe 'filtering' do
      let!(:meal1) { FactoryGirl.create(:meal, user: user, calories: 10, created_at: '2015-02-14 10:00') }
      let!(:meal2) { FactoryGirl.create(:meal, user: user, calories: 100, created_at: '2015-02-15 10:30') }
      let!(:meal3) { FactoryGirl.create(:meal, user: user, calories: 200, created_at: '2015-02-15 11:00') }

      let!(:meal4) { FactoryGirl.create(:meal, user: user, calories: 200, created_at: '2015-02-16 10:00') }
      let!(:meal5) { FactoryGirl.create(:meal, user: user, calories: 200, created_at: '2015-02-17 12:00') }

      it 'returns all meals with empty filter' do
        get meals_path, format: :json
        assert_response :success
        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq 5
      end

      it 'should filter by date' do
        get meals_path, format: :json, filter_meals: { from: '2015-02-15', to: '2015-02-16' }
        assert_response :success
        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq 3

        ids = json_response.map { |item| item[:id] }
        expect(ids).to eq [meal2.id, meal3.id, meal4.id]
      end

      it 'should filter by time' do
        get meals_path, format: :json, filter_meals: { from_time: '11:00', to_time: '15:00' }
        assert_response :success
        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq 2

        ids = json_response.map { |item| item[:id] }
        expect(ids).to eq [meal3.id, meal5.id]
      end

      it 'should filter by date and time' do
        get meals_path, format: :json, filter_meals: { from: '2015-02-14', to: '2015-02-16', from_time: '10:00', to_time: '15:00' }
        assert_response :success
        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq 4

        ids = json_response.map { |item| item[:id] }
        expect(ids).to eq [meal1.id, meal2.id, meal3.id, meal4.id]
      end
    end
  end
end

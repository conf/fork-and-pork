require 'rails_helper'

RSpec.describe 'Meals', type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_meal) { FactoryGirl.build(:meal, user: user) }

  before do
    login(user)
  end

  describe 'json' do

    describe 'on creation' do
      it 'should create meal on success' do
        post meals_path, format: :json, meal: valid_meal.attributes
        assert_response :created
      end

      it 'should return errors on fail' do
        post meals_path, format: :json, meal: { calories: 100 }
        assert_response :unprocessable_entity
        expect(json_response).to have_key :errors
      end
    end


    describe 'information retrieval' do

      let!(:meals) { FactoryGirl.create_list(:meal, 3, user: user) }
      let(:meal) { meals.first }

      it 'should get list of meals' do
        get meals_path, format: :json
        assert_response :success
        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq 3
      end

      describe 'single meal' do
        it 'should get a single meal' do
          get meal_path(meal), format: :json
          assert_response :success
          expect(json_response).to be_a(Hash)
          expect(json_response[:id]).to eq meal.id
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
  end
end

require 'rails_helper'

RSpec.describe Api::V1::StatusController, type: :controller do
  describe '#create' do
    def post!
      post :create, params: params
    end

    let(:params) do
      { current_status: current_status }
    end

    context 'unauthenticated user' do
      let(:current_status) { "UP" }

      it 'redirects to new user signup' do
        post!
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'authenticated user' do
      let(:user) { create :user }

      before do
        sign_in user
      end

      shared_examples_for 'an invalid request' do
        it 'returns 400' do
          post!
          expect(response.status).to eql(400)
        end

        it 'returns invalid current status message' do
          post!
          expect(response.parsed_body).to include('Current status is not valid. It can only be either UP or DOWN')
        end
      end

      context 'with invalid current_status' do
        let(:current_status) { %w[123 elephant mango].sample }

        it_behaves_like 'an invalid request'
      end

      context 'with empty current_status' do
        let(:params) { {} }

        it_behaves_like 'an invalid request'
      end

      context 'with valid current_status' do
        let(:current_status) { %w[UP DOWN up down].sample }

        it 'returns 200' do
          post!
          expect(response.status).to eql(200)
        end

        it 'creates new Status' do
          expect { post! }.to change { Status.count }.by(1)
        end
      end
    end
  end
end

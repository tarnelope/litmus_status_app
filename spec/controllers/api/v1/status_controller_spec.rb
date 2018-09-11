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

      shared_examples_for 'a valid request' do
        it 'returns 200' do
          post!
          expect(response.status).to eql(200)
        end

        it 'creates new Status' do
          expect { post! }.to change { Status.count }.by(1)
        end
      end

      describe 'invalid current_status' do
        context 'current_status is number string' do
          let(:current_status) { '123' }
          it_behaves_like 'an invalid request'
        end

        context 'current_status is string no equal to up or down' do
          let(:current_status) { 'elephant' }
          it_behaves_like 'an invalid request'
        end
      end

      context 'empty current_status' do
        let(:params) { {} }
        it_behaves_like 'an invalid request'
      end

      describe 'uppercase valid current_status' do
        context 'current_status=UP' do
          let(:current_status) { 'UP' }
          it_behaves_like 'a valid request'
        end

        context 'current_status=DOWN' do
          let(:current_status) { 'DOWN' }
          it_behaves_like 'a valid request'
        end
      end

      describe 'lowercase valid current_status' do
        context 'current_status=up' do
          let(:current_status) { 'up' }
          it_behaves_like 'a valid request'
        end

        context 'current_status=down' do
          let(:current_status) { 'down' }
          it_behaves_like 'a valid request'
        end
      end

      context 'valid current_status without a description' do
        let(:current_status) { 'UP' }

        it_behaves_like 'a valid request'

        it 'does not create new StatusMessage' do
          expect { post! }.not_to change { StatusMessage.count }
        end
      end

      context 'valid current_status with description' do
        let(:params) do
          {
            current_status: "UP",
            description: "Describing a message here"
          }
        end

        it_behaves_like 'a valid request'

        it 'creates new StatusMessage' do
          expect { post! }.to change {StatusMessage.count }.by(1)
        end
      end
    end
  end
end

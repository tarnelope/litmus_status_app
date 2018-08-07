require 'rails_helper'

RSpec.describe Api::V1::StatusMessagesController, type: :controller do
  describe '#create' do
    def post!
      post :create, params: params
    end

    let(:params) do
      { description: description }
    end

    context 'invalid description' do
      let(:description) {
        'iC6z4uRWRW1OkUJwZksA97ashQ7MO7j6l7jz4u16Ln4o88Tmi8Q3lXxtk7dlGMbZC2xJAbW
        24yuD5v91Ti5MRN5bY9zS9yZ08xqnU1ww0z5o47jKpqlXBeXGQGDK1bR21v392a9FE72Y2ri
        pNr66THgTkOmUZYe6yd0SI69eQAj7Yp7Dc4d92j524R4iLJYBA7Z7AFRcziEUp7xKhnXX32E
        NjA8u9W8fgG0kOYyb6S5sSdeuBlul5631PCK2Y1x9i'
      }

      it 'returns 400' do
        post!

        expect(response.status).to eql(400)
      end
    end

    context 'valid description' do
      let(:description) { 'Hello I am a status message blah blah blah' }

      it 'returns 200' do
        post!

        expect(response.status).to eql(200)
      end

      it 'creates a message' do
        expect { post! }.to change { StatusMessage.count }.by(1)
      end
    end

  end
end

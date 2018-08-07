require 'rails_helper'

RSpec.describe StatusMessage, type: :model do
  describe '#description' do
    it {
      should allow_values('', 'hello', 'Letters and Numbers cool 1234543 (#&$(#*&$(*#)))'). for(:description)
    }

    context 'over 256 characters' do
      let(:description) do
        'iC6z4uRWRW1OkUJwZksA97ashQ7MO7j6l7jz4u16Ln4o88Tmi8Q3lXxtk7dlGMbZC2xJAbW
        24yuD5v91Ti5MRN5bY9zS9yZ08xqnU1ww0z5o47jKpqlXBeXGQGDK1bR21v392a9FE72Y2ri
        pNr66THgTkOmUZYe6yd0SI69eQAj7Yp7Dc4d92j524R4iLJYBA7Z7AFRcziEUp7xKhnXX32E
        NjA8u9W8fgG0kOYyb6S5sSdeuBlul5631PCK2Y1x9i'
      end

      it {
        should_not allow_value(description). for(:description)
      }
    end
  end
end

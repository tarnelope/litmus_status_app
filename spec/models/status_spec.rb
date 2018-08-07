require 'rails_helper'

RSpec.describe Status, type: :model do
  describe '#current_status' do
    it {
      should allow_values('up', 'down', 'UP', 'down'). for(:current_status)
    }

    it {
      should_not allow_values(1, true, 'zebra', 'abc 123'). for(:current_status)
    }
  end
end

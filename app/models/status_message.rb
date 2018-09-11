class StatusMessage < ApplicationRecord
  attribute :description, :text, default: ''

  validates :description, length: { maximum: 256, too_long: 'Sorry! There is a 256 character limit.' }
end

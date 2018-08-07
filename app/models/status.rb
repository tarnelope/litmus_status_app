class Status < ApplicationRecord
  attribute :current_status, :string

  validate :validate_current_status

  private

  def validate_current_status
    return if current_status.instance_of?(String) && %w[UP DOWN].include?(current_status.upcase.strip)

    errors[:current_status] << 'is not valid'
  end
end

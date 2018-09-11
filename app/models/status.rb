class Status < ApplicationRecord
  attribute :current_status, :string

  validate :validate_current_status

  before_save :format_current_status

  private

  def validate_current_status
    return if current_status.instance_of?(String) && %w[up down UP DOWN].include?(current_status)

    errors[:current_status] << 'is not valid. It can only be either UP or DOWN'
  end

  def format_current_status
    return if %w[UP DOWN].include?(self.current_status)
    self.current_status = self.current_status.upcase.strip
  end
end

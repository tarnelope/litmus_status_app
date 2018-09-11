class StaticPagesController < ApplicationController
  include Pagy::Backend

  def index
    @current_status = current_status
    @pagy, @status_messages = status_messages
  end

  private

  def current_status
    # TODO: Status.last returns nil if no status exist which wouldn't raise the exception. Either accept the changes where the status_pages_helper#status_class can handle current_status = nil or update to raise and handle exception.
    begin
      @_current_status = Status.last
    rescue ActiveRecord::RecordNotFound
      puts "Exception: Status not created"
    end
  end

  def status_messages
    @_status_messages ||= pagy(StatusMessage.order(created_at: :desc), items: 10)
  end
end

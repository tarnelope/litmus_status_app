class StaticPagesController < ApplicationController
  include Pagy::Backend

  def index
    @current_status = current_status
    @pagy, @status_messages = status_messages
  end

  private

  def current_status
    @_current_status ||= Status.last
  end

  def status_messages
    @_status_messages ||= pagy(StatusMessage.order(created_at: :desc), items: 10)
  end
end

class StaticPagesController < ApplicationController
  def index
    @current_status = current_status
    @status_messages = status_messages
  end

  private

  def current_status
    @_current_status ||= Status.last
  end

  def status_messages
    @_status_messages ||= StatusMessage.order(created_at: :desc)
  end
end

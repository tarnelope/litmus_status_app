module Api
  module V1
    class StatusMessagesController < ApplicationController
      before_action :authenticate_user!, only: :create

      def create
        @status_message = StatusMessage.new(permitted_params)

        if @status_message.save
          render json: @status_message, status: 200
        else
          render json: @status_message.errors.full_messages, status: 400
        end
      end

      private

      def permitted_params
        params.permit(:description)
      end
    end
  end
end

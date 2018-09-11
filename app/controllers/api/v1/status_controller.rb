module Api
  module V1
    class StatusController < ApplicationController
      before_action :authenticate_user!, only: :create

      def create
        @status = Status.new(status_permitted_params)

        if params[:description]
          StatusMessage.create(message_permitted_params)
          
          # TODO: Add more defense against bad messages
          # status_message = StatusMessage.new(message_permitted_params)
          # unless status_message.save
          #   render json: @status_message.errors.full_messages, status: 400
          # end
        end

        if @status.save
          render json: @status, status: 200
        else
          render json: @status.errors.full_messages, status: 400
        end
      end

      private

      def status_permitted_params
        params.permit(:current_status)
      end

      def message_permitted_params
        params.permit(:description)
      end
    end
  end
end

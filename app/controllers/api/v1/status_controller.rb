module Api
  module V1
    class StatusController < ApplicationController
      def create
        @status = Status.new(permitted_params)

        if @status.save
          render json: @status, status: 200
        else
          render json: @status.errors.full_messages, status: 400
        end
      end

      private

      def permitted_params
        params.permit(:current_status)
      end
    end
  end
end

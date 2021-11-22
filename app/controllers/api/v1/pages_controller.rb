module Api
  module V1
    class PagesController < ApplicationController
      before_action :set_pages, only: [:show, :update, :destroy]

      def show
        render json: @page
      end

      def create
        @page = Page.new(page_params)

        if @page.save 
          render json: @page, status: :created
        else 
          render json: { errors: @page.errors.full_messages }, status: :bad_request
        end
      end

      def update
        if @page.update(page_params) 
          render json: @page, status: :accepted
        else 
          render json: { errors: @page.errors.full_messages }, status: :bad_request
        end
      end

      def destroy
        if @page.destroy
          render json: @page, status: :accepted
        else 
          render json: { errors: @page.errors.full_messages }, status: :bad_request
        end
      end

      private

      def set_pages
        @page = Page.find_by(article_id: params[:id])
      end

      def page_params
        params.require(:page).permit(:number, :content, :article_id)
      end
    
    end
  end
end
module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: [:show, :update, :destroy]

      def index
        render json: Category.all
      end 
      
      def show 
        render json: @category
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          render json: @category, status: :created
        else
          render json: { errors: @category.errors.full_messages}, status: :bad_request
        end
      end

      def update
        if @category.update(category_params) 
          render json: @category, status: :accepted
        else 
          render json: { errors: @category.errors.full_messages }, status: :bad_request
        end
      end

      def destroy
        if @category.destroy
          render json: @category, status: :accepted
        else
          render json: { errors: @category.errors.full_messages }, status: :bad_request 
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end 

      def category_params
        params.require(:category).permit(:name, :url)
      end
    end
  end
end
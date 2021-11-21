module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: [:show, :update, :destroy]

      def index
        render json: Article.all
      end 

      def show
        render json: @article
      end

      def create
        @article = Article.new(article_params)

        if @article.save 
          render json: @article, status: :created
        else 
          render json: { errors: @article.errors.full_messages }
        end
      end

      def update
        if @article.update(article_params) 
          render json: @article, status: :accepted
        else 
          render json: { errors: @article.errors.full_messages }, status: :bad_request 
        end
      end

      def destroy
        if @article.destroy
          render json: @article, status: :accepted
        else
          render json: { errors: @article.errors.full_messages }, status: :bad_request 
        end
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :active, :category_id)
      end

    end
  end
end
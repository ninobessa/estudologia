module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [ :show, :update, :destroy ]

      def index
        @posts = Post.all
      end

      def show; end

      def create
        @post = current_user.posts.new(post_params)

        if @post.save
          render :show, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render :show, status: :ok
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @post.destroy
          head :no_content
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = current_user.posts.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Post not found" }, status: :not_found
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end

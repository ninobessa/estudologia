module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_post
      before_action :set_comment, only: :destroy

      def index
        @comments = @post.comments
      end

      def create
        @comment = @post.comments.build(comment_params)

        if @comment.save
          render :show, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find_by(id: params[:post_id])
        render json: { error: "Post not found" }, status: :not_found unless @post
      end

      def set_comment
        @comment = @post.comments.find_by(id: params[:id])
        render json: { error: "Comment not found" }, status: :not_found unless @comment
      end

      def comment_params
        params.require(:comment).permit(:name, :title, :content)
      end
    end
  end
end

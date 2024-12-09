require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:user_token) { token(user) }
  let(:valid_comment_attributes) { { name: "Test User", content: "Test Content" } }
  let(:invalid_comment_attributes) { { name: "", content: "" } }
  let!(:user_post) { create(:post, user: user) }
  let!(:comment) { create(:comment, post: user_post) }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    it "returns http success and a list of comments" do
      post = create(:post, user: user)
      create_list(:comment, 3, post: post)

      get_with_auth api_v1_post_comments_path(post), user_token

      expect(response).to have_http_status(:success)
      expect(json.size).to eq(3)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment and returns http created status" do
        expect {
          post api_v1_post_comments_path(user_post), params: { comment: valid_comment_attributes }
        }.to change(Comment, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment and returns http unprocessable_entity status" do
        expect {
          post api_v1_post_comments_path(user_post), params: { comment: invalid_comment_attributes }
        }.not_to change(Comment, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested Comment and returns http no_content status" do
      expect {
        destroy_with_auth api_v1_post_comment_path(user_post, comment), user_token
      }.to change(Comment, :count).by(-1)

      expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to have_http_status(:no_content)
    end
  end
end

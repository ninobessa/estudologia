require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:user_token) { token(user) }
  let(:invalid_post_attributes) { { title: nil, content: "Invalid post without title." } }
  let(:valid_post_attributes) { { title: "Title", content: "Content" } }

  describe "GET /index" do
    before do
      sign_in user
    end

    it "returns http success" do
      get_with_auth api_v1_posts_path, user_token
      expect(response).to have_http_status(:success)
    end

    it "returns a list of posts" do
      create_list(:post, 3, user: user)

      get_with_auth api_v1_posts_path, user_token
      expect(json.size).to eq(3)
    end
  end

  describe "GET /show" do
    let(:valid_post) { create(:post, user: user) }

    before do
      sign_in user
      get_with_auth api_v1_post_path(valid_post), user_token
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the correct post" do
      expect(json['id']).to eq(valid_post.id)
    end
  end

  describe "POST /create" do
    before do
       sign_in user
    end

    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post api_v1_posts_path, params: { post: valid_post_attributes }
        }.to change(Post, :count).by(1)
      end

      it "returns http created status" do
        post api_v1_posts_path, params: { post: valid_post_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post api_v1_posts_path, params: { post: invalid_post_attributes }
        }.to change(Post, :count).by(0)
      end

      it "returns http unprocessable_entity status" do
        post api_v1_posts_path, params: { post: invalid_post_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let(:valid_post) { create(:post, user: user) }

    before do
      sign_in user
    end

    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Title", content: "Updated content." } }

      it "updates the requested Post" do
        patch api_v1_post_path(valid_post), params: { post: new_attributes }
        valid_post.reload
        expect(valid_post.title).to eq("Updated Title")
        expect(valid_post.content).to eq("Updated content.")
      end

      it "returns http success status" do
        patch api_v1_post_path(valid_post), params: { post: new_attributes }
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid parameters" do
      let(:invalid_update_attributes) { { title: nil } }

      it "does not update the requested Post" do
        patch api_v1_post_path(valid_post), params: { post: invalid_update_attributes }
        valid_post.reload
        expect(valid_post.title).not_to be_nil
      end

      it "returns http unprocessable_entity status" do
        patch api_v1_post_path(valid_post), params: { post: invalid_update_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:valid_post) { create(:post, user: user) }

    before do
      sign_in user
      destroy_with_auth api_v1_post_path(valid_post), user_token
    end

    it "destroys the requested Post" do
      expect {
        valid_post.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "returns http ok status" do
      expect(response).to have_http_status(:no_content)
    end
  end
end

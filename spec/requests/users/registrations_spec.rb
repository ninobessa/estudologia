RSpec.describe "User Registrations", type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }

  describe "POST /users" do
    context "when user is valid" do
      before do
        sign_up(user)
      end

      it 'returns 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'returns an authorization token' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns the user email' do
        expect(json['user']['email']).to eq(user.email)
      end
    end

    context "when user is not valid" do
      before do
        sign_up(existing_user)
      end

      it 'returns 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not return an authorization token' do
        expect(response.headers['Authorization']).to be_blank
      end

      it 'returns an error message' do
        expect(json['message']).to include("User couldn't be created successfully")
      end
    end
  end

  describe "DELETE /users" do
    context "when user is valid" do
      before do
        delete_account(existing_user)
      end

      it "destroys the requested User" do
        expect {
          existing_user.reload
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns 200 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end

RSpec.describe "User Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /users/sign_in" do
    context "when credentials are valid" do
      before do
        sign_in(user)
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a token in the Authorization header' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns the user email in the response body' do
        expect(json.dig('user', 'email')).to eq(user.email)
      end
    end

    context "when credentials are not valid" do
      before do
        user.password = :invalid_password
        sign_in(user)
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'does not return a token in the Authorization header' do
        expect(response.headers['Authorization']).to be_blank
      end

      it 'returns an error message indicating invalid credentials' do
        expect(json.dig('error')).to include("Invalid Email or password")
      end
    end
  end

  describe "DELETE /users/sign_out" do
    context "when the user is signed in" do
      before do
        sign_in(user)
        sign_out(token(user))
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end

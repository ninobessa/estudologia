module AuthenticationHelpers
  def auth_headers(auth)
    {
      'Authorization': auth,
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  end

  def sign_up(user)
    post user_registration_path, params: {
      user: user.slice(:name, :email, :password)
    }
  end

  def delete_account(user)
    sign_in(user)
    delete user_registration_path
    response
  end

  def sign_in(user)
    post user_session_path, params: {
      user: user.slice(:email, :password)
    }
  end

  def sign_out(auth)
    delete destroy_user_session_path, headers: auth_headers(auth)
  end

  def token(user)
    sign_in(user)
    response.headers['Authorization']&.split(' ')&.last
  end

  def get_with_auth(path, auth)
    get path, headers: auth_headers(auth)
  end

  def destroy_with_auth(path, auth)
    delete path, headers: auth_headers(auth)
  end
end

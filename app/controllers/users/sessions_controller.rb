# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      render :create, status: :ok
    else
      render :create_error_bad_credentials, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    if request.headers["Authorization"].present?
      render :destroy, status: :ok
    else
      render :destroy_error, status: :unauthorized
    end
  end
end

# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    case request.method
    when "POST"
      if resource.persisted?
        render :create, status: :created
      else
        render :create_error, status: :unprocessable_entity
      end
    when "DELETE"
      render :destroy, status: :no_content
    end
  end
end

require "ostruct"

module AuthenticationConcern
  extend ActiveSupport::Concern

  AUTHORIZATION_ERROR_KINDS =
    ActiveSupport::HashWithIndifferentAccess.new

  AUTHORIZATION_ERROR_KINDS[:unauthorized] = "unauthorized"
  AUTHORIZATION_ERROR_KINDS[:forbidden] = "forbidden"

  included do
    before_action :login_required!
    before_action :admin_required!
  end

  private

  def login_required!
    kind = AUTHORIZATION_ERROR_KINDS[:unauthorized]
    return authorization_error_response(kind) unless validate_token(get_token)

    authorize(validate_token(get_token))
    user = OpenStruct.new(validate_token(get_token)["UserInfo"])
    @current_user = user
  end

  def admin_required!
    kind = AUTHORIZATION_ERROR_KINDS[:forbidden]
    decoded_token = validate_token(get_token)
    user = User.find_by(id: decoded_token["UserInfo"]["id"])
    return authorization_error_response(kind) unless user && admin?(user)

    @current_user = user
  end

  def admin?(user)
    user.role.name == "Admin"
  end

  def andelan?(email)
    email["andela.com"] ? true : false
  end

  def get_token
    auth_header = request.headers["Authorization"]
    return nil unless auth_header

    auth_header.split(" ")[1]
  end

  def validate_token(token)
    JWT.decode(*jwt_params(token)).first
  rescue JWT::VerificationError, JWT::IncorrectAlgorithm, JWT::DecodeError
    false
  end

  def authorize(token)
    kind = AUTHORIZATION_ERROR_KINDS[:unauthorized]
    user_info = token["UserInfo"]
    return authorization_error_response(kind) if user_info.nil?

    email = user_info["email"]
    return authorization_error_response(kind) if email.nil?

    authorization_error_response(kind) unless andelan?(email)
  end

  def jwt_params(token)
    [token, nil, false]
  end

  def authorization_error_response(kind)
    error_resource = {}
    error_resource[:status] =
      I18n.t("errors.application.#{kind}.status")
    error_resource[:title] =
      I18n.t("errors.application.#{kind}.title")
    error_resource[:detail] =
      I18n.t("errors.application.#{kind}.detail")
    error_resource[:errors] =
      [I18n.t("errors.application.#{kind}.error_message")]

    render_response(error_resource, kind.to_sym)
  end
end

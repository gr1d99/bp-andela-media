class ApplicationController < ActionController::API
  before_action :set_locale
  include Response
  include ExceptionHandler

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def authenticate
    token = get_token
    decoded_token = validate_token(token)
    return unauthorized unless decoded_token

    user = User.find_by(id: decoded_token["UserInfo"]["id"])
    return head :forbidden unless user && admin?(user)

    @current_user = user
  end

  def unauthorized
    head :unauthorized
  end

  def admin?(user)
    user.role.name == "Admin"
  end

  def get_token
    return nil unless request.headers["Authorization"]

    request.headers["Authorization"].split(" ")[1]
  end

  def validate_token(token)
    JWT.decode(*jwt_params(token)).first
  rescue JWT::VerificationError, JWT::IncorrectAlgorithm, JWT::DecodeError
    false
  end

  def jwt_params(token)
    [token, nil, false]
  end
end

class ApplicationController < ActionController::API
  before_action :set_locale
  include Response
  include ExceptionHandler

  def authenticate
    token = get_token
    decoded_token = validate_token(token)
    if decoded_token
      @current_user = User.find_by(camper_id: decoded_token["UserInfo"]["id"])
    else
      head :unauthorized
    end
  end

  def admin?(current_user)
    current_user.role.role == "Admin"
  end

  def get_token
    return nil unless request.headers["Authorization"]

    request.headers["Authorization"].split(" ")[1]
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
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

module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    before_action :login_required!
    before_action :admin_required!
  end

  private

  def login_required!
    unauthorized unless validate_token(get_token)
  end

  def admin_required!
    decoded_token = validate_token(get_token)
    user = User.find_by(id: decoded_token["UserInfo"]["id"])
    return forbidden unless user && admin?(user)

    @current_user = user
  end

  def admin?(user)
    user.role.name == "Admin"
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

  def jwt_params(token)
    [token, nil, false]
  end

  def unauthorized
    error_resource = {}
    error_resource[:status] =
      I18n.t("errors.application.unauthorized.status")
    error_resource[:title] =
      I18n.t("errors.application.unauthorized.title")
    error_resource[:detail] =
      I18n.t("errors.application.unauthorized.detail")
    error_resource[:errors] =
      [I18n.t("errors.application.unauthorized.error_message")]

    render_response(error_resource, :unauthorized)
  end

  def forbidden
    error_resource = {}
    error_resource[:status] =
      I18n.t("errors.application.forbidden.status")
    error_resource[:title] =
      I18n.t("errors.application.forbidden.title")
    error_resource[:detail] =
      I18n.t("errors.application.forbidden.detail")
    error_resource[:errors] =
      [I18n.t("errors.application.forbidden.error_message")]

    render_response(error_resource, :forbidden)
  end
end

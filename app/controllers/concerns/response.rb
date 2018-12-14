module Response
  def render_response(object, status = :ok)
    render json: object, status: status
  end
end

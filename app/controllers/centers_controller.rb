class CentersController < ApplicationController
  def index
    center = Center.all
    render_response(center, :ok)
  end
end

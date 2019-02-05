class CentersController < ApplicationController
  skip_before_action :admin_required!, only: %i[index]

  def index
    center = Center.all
    render_response(center, :ok)
  end
end

class AlbumsController < ApplicationController
  def create
    @album = Albums::CreateAlbum.call(params)

    if @album.success?
      render json: @album.model, status: :created
    else
      render json: @album.model.errors, status: :unprocessable_entity
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :user_id, :position,
                                  :metadata, :preferences, tag_list: [])
  end
end

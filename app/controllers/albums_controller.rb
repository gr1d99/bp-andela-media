class AlbumsController < ApplicationController
  before_action :set_album, only: %i[update destroy]

  def create
    album = Albums::CreateAlbum.call(params)

    if album.success?
      render json: album.model, status: :created
    else
      render json: album.model.errors, status: :unprocessable_entity
    end
  end

  def update
    if @album.update(update_params)
      render json: @album, status: :ok
    else
      render json: @album.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @album.present?
      @album.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def update_params
    params.require(:album).permit(:title)
  end

  def set_album
    @album = Album.find_by(id: params[:id])
  end
end

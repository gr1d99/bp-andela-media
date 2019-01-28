class AddCenterToAlbum < ActiveRecord::Migration[5.2]
  def change
    add_reference :albums, :center, type: :uuid, foreign_key: true
  end
end

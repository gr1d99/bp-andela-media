class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums, id: :uuid do |t|
      t.string :title, null: false, limit: 64, unique: true
      t.text :description
      t.jsonb :metadata, default: {}
      t.integer :position, default: 0, null: false
      t.jsonb :preferences, default: {}
      t.uuid :user_id, null: false

      t.timestamps
    end
  end
end

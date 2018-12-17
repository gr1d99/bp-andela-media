class JoinAlbumsAndUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_join_table :albums, :user_groups do |t|
      t.column :user_group_id, :uuid
      t.column :album_id, :uuid

      t.index [:album_id, :user_group_id]
    end
  end
end

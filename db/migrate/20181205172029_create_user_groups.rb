class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.string :name, limit: 32, null: false
      t.jsonb :emails, default: {}

      t.timestamps
    end
  end
end

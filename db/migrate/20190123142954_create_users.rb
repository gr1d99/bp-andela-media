class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, primary_key: true
      t.string :email
      t.string :first_name
      t.string :last_name
      t.jsonb :andela

      t.references :role, foreign_key: true

      t.timestamps
    end
    add_index :users, :email, unique: true
    Rake::Task["users:populate_admin"].invoke
  end
end

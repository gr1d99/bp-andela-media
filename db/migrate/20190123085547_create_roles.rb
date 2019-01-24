class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :role

      t.timestamps
    end
    Rake::Task["roles:populate_roles"].invoke
  end
end

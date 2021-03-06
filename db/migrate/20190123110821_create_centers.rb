class CreateCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :centers, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    Rake::Task['db:create_or_update_centers'].invoke
  end
end

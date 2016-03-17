class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :user_ids, array: true, default: []
      t.string :name, null: false
      t.integer :owner_id, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end

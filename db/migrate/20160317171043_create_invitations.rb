class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :invitations, :user_id
  end
end

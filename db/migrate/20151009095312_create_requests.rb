class CreateRequests < ActiveRecord::Migration
  def up
    create_table :requests do |t|
      t.string :email
      t.string :registration_key
      t.boolean :approved, null: false, default: false

      t.timestamps null: false
    end
    
    add_index :requests, :email, unique: true
  end

  def down
    drop_table :requests
  end
end
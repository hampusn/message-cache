class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.text :message
      t.text :meta

      t.timestamps null: false
    end
  end

  def down
    drop_table :messages
  end
end

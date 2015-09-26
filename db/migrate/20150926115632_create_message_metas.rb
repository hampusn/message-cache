class CreateMessageMetas < ActiveRecord::Migration
  def up
    create_table :message_metas do |t|
      t.references :message, index: true
      t.text :key
      t.text :value

      t.timestamps null: false
    end
  end

  def down
    drop_table :message_metas
  end
end

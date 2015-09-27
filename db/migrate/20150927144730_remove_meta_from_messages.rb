class RemoveMetaFromMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.remove :meta
    end
  end

  def down
    change_table :messages do |t|
      t.text :meta
    end
  end
end

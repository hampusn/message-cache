class AddUserToMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :user, index: true
    end
  end

  def down
    change_table :messages do |t|
      t.remove :user_id
    end
  end
end

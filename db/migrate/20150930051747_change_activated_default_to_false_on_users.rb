class ChangeActivatedDefaultToFalseOnUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :activated, false
  end
end

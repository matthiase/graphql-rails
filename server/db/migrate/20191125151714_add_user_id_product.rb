class AddUserIdProduct < ActiveRecord::Migration[6.0]
  def up
    add_reference :products, :user, index: true, foreign_key: true
  end

  def down
    remove_reference :products, :user, index: true, foreign_key: true
  end
end

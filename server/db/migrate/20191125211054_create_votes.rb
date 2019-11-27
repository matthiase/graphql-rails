class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :product, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
    add_index :votes, [:product_id, :user_id], unique: true
  end
end

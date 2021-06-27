class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end

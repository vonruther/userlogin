class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :name, :string
  	add_column :users, :age, :integer
  	add_column :users, :address, :string
  	add_column :users, :gender, :string
  end
end

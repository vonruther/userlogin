class FixColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :posts, :publish, :public
  end
end

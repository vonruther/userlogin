class ChangePostColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :posts, :userid, :user_id
  end
end

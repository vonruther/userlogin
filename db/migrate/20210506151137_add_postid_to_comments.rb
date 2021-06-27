class AddPostidToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :postid, :integer
  end
end

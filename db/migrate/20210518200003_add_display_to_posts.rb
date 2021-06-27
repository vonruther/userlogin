class AddDisplayToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :display, :boolean, default: 1
  end
end

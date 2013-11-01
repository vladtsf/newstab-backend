class AddIndexHrefToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :href, unique: true
  end
end

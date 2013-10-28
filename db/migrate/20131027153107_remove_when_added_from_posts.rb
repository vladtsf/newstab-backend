class RemoveWhenAddedFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :when_added, :datetime
  end
end

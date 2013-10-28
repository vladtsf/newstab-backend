class AddFeedSourceIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :feed_source_id, :integer
    add_index  :posts, :feed_source_id
  end
end

class AddIndexInFeedFieldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :index_in_feed, :integer
  end
end

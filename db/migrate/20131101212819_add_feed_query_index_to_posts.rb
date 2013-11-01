class AddFeedQueryIndexToPosts < ActiveRecord::Migration
  def change
    add_index(:posts, [:created_at, :index_in_feed], :order => {:created_at => :desc, :index_in_feed => :asc})
  end
end

class CreateFeedSources < ActiveRecord::Migration
  def change
    create_table :feed_sources do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end

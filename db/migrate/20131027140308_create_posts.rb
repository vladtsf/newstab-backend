class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image_src
      t.integer :image_width
      t.integer :image_height
      t.string :href
      t.datetime :when_added

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, null: false, unique: true
      t.date :published_at
      t.string :link, null: false, unique: true
      t.string :guid, null: false, unique: true
      t.string :author
      t.string :thumbnail
      t.string :description
      t.string :content
      t.json :enclosure
      t.json :tags
      t.timestamps
    end
  end
end

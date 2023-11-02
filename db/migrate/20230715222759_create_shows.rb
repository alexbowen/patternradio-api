class CreateShows < ActiveRecord::Migration[7.0]
  def change
    create_table :shows, id: :uuid do |t|
      t.string :key, null: false, unique: true
      t.string :url, null: false, unique: true
      t.string :name, null: false, unique: true
      t.datetime :created_time
      t.datetime :updated_time
      t.integer :play_count
      t.integer :favorite_count
      t.integer :comment_count
      t.integer :listener_count
      t.integer :repost_count
      t.boolean :hidden_stats
      t.string :slug
      t.integer :audio_length
      t.json :pictures
      t.json :tags
      t.json :user
      t.timestamps
    end
  end
end

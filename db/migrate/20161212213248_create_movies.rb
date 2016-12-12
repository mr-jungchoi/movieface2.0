class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string   :youtube_trailer_id, null: false
      t.string   :title, null: false
      t.string   :year, null: false
      t.string   :rated
      t.string   :runtime
      t.string   :director, null: false
      t.string   :writer, null: false
      t.string   :actors
      t.string   :plot, null: false
      t.references :genre

      t.timestamps
    end
  end
end

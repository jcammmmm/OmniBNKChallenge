class CreateUserMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :user_movies do |t|
      t.string :movie_id
      t.string :user_id

      t.timestamps
    end
    add_index :user_movies, :movie_id
    add_index :user_movies, :user_id
  end
end

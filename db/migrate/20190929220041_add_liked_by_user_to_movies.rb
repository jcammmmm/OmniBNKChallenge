class AddLikedByUserToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :liked_by_user, :boolean
  end
end

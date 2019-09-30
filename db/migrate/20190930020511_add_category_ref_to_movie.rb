class AddCategoryRefToMovie < ActiveRecord::Migration[6.0]
  def change
    add_reference :movies, :category, foreign_key: true
  end
end

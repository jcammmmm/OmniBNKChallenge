class Movie < ApplicationRecord
	def self.already_liked_by(user_id, movie_id)
		movie = Movie.where("user_id = ? and movie_id = ?", user_id, movie_id)
		if movie == nil
			return false
		else
			return true
		end
	end

	def self.all_liked_by(user_id)
		movies = Movie.all
		users_movies = UserMovie.where("user_id =  ?", user_id)
		movies.each do |movie|
			users_movies.each do |like|
				if movie.id == like.movie_id.to_i
					movie.liked_by_user = true
				end
			end
			puts movie.liked_by_user
		end
		return movies
	end

	def self.was_liked_by_user
		@liked_by_user
	end
end

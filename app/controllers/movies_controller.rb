class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all_liked_by(current_user.id)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /movies_add_to_favorites/1
  def addToFavorites
	# a user likes a movie if is stored in UserMovie associated table
		user_movie = UserMovie.create(movie_id: params[:id], user_id: current_user.id) # at this point is always guarranteed a login
		respond_to do |format|
			format.html { redirect_to movies_url, notice: 'you like this movie!' }
        	format.json { head :no_content }
		end
  end

  # GET /romove_from_favorites/1
  def removeFromFavorites
	user_movie = UserMovie.where("user_id = ? and movie_id = ?", current_user.id, params[:id])
	user_movie.each do |um|
		um.destroy
	end
	respond_to do |format|
		format.html { redirect_to movies_url, notice: 'you dislike this movie!' }
        format.json { head :no_content }
	end
  end

  def recomendations
	fav_movies_ids = UserMovie.where("user_id = ?", current_user.id) # retrieve all liked movies from current user
	favorite_movies = []
	Movie.all_liked_by(current_user.id).each do |movie| # Here we prefer fetch all movies vs retrieve each favorite movie for performance purposes
		fav_movies_ids.each do |fav_movie|
			if movie.id == fav_movie.movie_id.to_i
				favorite_movies.push(movie)
			end
		end
	end
	@recommended_movies = favorite_movies
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :description)
    end
end

class MoviesController < ApplicationController
  require 'sort_by_rank.rb'
  require 'vote.rb'
  include SortByRank
  include Vote

  def index
    @movies = sort_by_rank(Movie.all)
  end

  def create
    @movie = Movie.create(movie_params)

    redirect_to movies_path
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to movie_path
    else
      render :edit
    end
  end

  def upvote
    movie = Movie.find(params[:id])
    add_vote(movie).save

    redirect_to movies_path
  end

  def downvote
    movie = Movies.find(params[:id])
    subtract_vote(movie).save

    redirect_to movies_path
  end


  def destroy
    @movie = Movie.find(params[:id]).destroy

    redirect_to movies_path
  end

  ####### STRONG PARAMS #########

  private

  def movie_params
    params.require(:movie).permit(:name, :director, :description, :rank_points)
  end
end

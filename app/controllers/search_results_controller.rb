class SearchResultsController < ApplicationController

  def index
    s = SodaAPI.new
    s.add_title(params[:query])
    # s.add_where_like_arg(sr_params[:query_type], sr_params[:query])
    @results = s.get
  end

  def show
    @result = params[:movie]
  end

  def advanced_show
    @movie = Movie.new
    'advanced_show'
  end


  private

  def sr_params
    params.permit(:query, :movie, :query_type)
  end
end

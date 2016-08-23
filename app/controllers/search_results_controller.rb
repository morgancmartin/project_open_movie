class SearchResultsController < ApplicationController

  def index
    s = SodaAPI.new
    if sr_params[:query_type]
      sr_params[:query_type] = 'locations' if sr_params[:query_type] == 'location'
      type = sr_params[:query_type] == 'location' ? 'locations' : sr_params[:query_type]
      s.add_where_like_arg(type, sr_params[:query])
    end
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

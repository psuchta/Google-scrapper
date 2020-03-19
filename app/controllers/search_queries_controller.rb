class SearchQueriesController < ApplicationController
  before_action :find_query, only: [:show, :edit, :destroy, :update]

  def index
    @search_query = SearchQuery.new
    @search_queries = SearchQuery.includes(:query_results)
  end

  def show; end

  def edit; end

  def destroy
    @search_query.destroy!
    redirect_to search_queries_path, notice: 'Query destroyed!'
  end

  def create
    SearchQuery.create_with_results(search_query_params: search_query_params)
    redirect_to search_queries_path, notice: 'Query created!'
  end

  def update
    @search_query.update_searched_quote search_query_params[:searched_quote]
    redirect_to search_queries_path, notice: 'Search Query updated!'
  end

  private

  def find_query
    @search_query = SearchQuery.find(params[:id])
  end

  def search_query_params
    params.require(:search_query).permit(:searched_quote)
  end
end

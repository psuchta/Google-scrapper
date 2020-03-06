class QueriesController < ApplicationController
  before_action :find_query, only: [:show, :edit, :destroy]

  def index
    @query = Query.new
    @queries = Query.includes(:query_results)
  end

  def show; end

  def edit; end

  def destroy
    @query.destroy!
    redirect_to queries_path, notice: "Query destroyed!"
  end

  def create
    Query.create_with_results(query_params)
    redirect_to queries_path
  end

  private

  def find_query
    @query = Query.find_by(id: params[:id])
    raise StandardError if @query.blank?
  end

  def query_params
    params.require(:query).permit(:searched_quote)
  end
end

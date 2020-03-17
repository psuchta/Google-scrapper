class AddQueryResultsCountToSearchQuery < ActiveRecord::Migration[6.0]
  def change
    add_column :search_queries, :query_results_count, :integer
  end
end

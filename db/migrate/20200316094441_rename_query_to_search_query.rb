class RenameQueryToSearchQuery < ActiveRecord::Migration[6.0]
  def change
    remove_reference :query_results, :query, foreign_key: true
    rename_table :queries, :search_queries
    add_reference :query_results, :search_query, foreign_key: true
  end
end

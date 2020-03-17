class RenameQueryQueryToSearchedQuote < ActiveRecord::Migration[6.0]
  def change
    rename_column :queries, :query, :searched_quote
  end
end

class SearchQuery < ApplicationRecord
  has_many :query_results, dependent: :destroy

  def self.create_with_results(search_query_params:, search_engine: GoogleLinksSearcher.new)
    ActiveRecord::Base.transaction do
      created_query = create!(search_query_params)
      created_query.update_or_create_query_results(search_engine: search_engine)
    end
  end

  def update_or_create_query_results(search_engine: GoogleLinksSearcher.new)
    search_results = search_engine.run_query(searched_quote)
    search_results.each do |search_result|
      QueryResult.create_or_update_by_link!(search_query_id: id,
                                            text: search_result.text,
                                            link: search_result.link)
    end
    self
  end
end
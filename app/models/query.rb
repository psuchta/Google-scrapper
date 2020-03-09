class Query < ApplicationRecord
  has_many :query_results, dependent: :destroy

  def self.create_with_results(query_params, search_engine = GoogleLinksSearcher.new)
    ActiveRecord::Base.transaction do
      created_query = create!(query_params)
      created_query.update_or_create_query_results(search_engine)
    end
  end

  def update_or_create_query_results(search_engine = GoogleLinksSearcher.new)
    google_results = search_engine.run_query(searched_quote)
    google_results.each do |google_result|
      QueryResult.create_or_update_result(id,
                                          google_result.text,
                                          google_result.link)
    end
    self
  end
end

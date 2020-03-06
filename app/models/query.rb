class Query < ApplicationRecord
  has_many :query_results, dependent: :destroy

  def self.create_with_results(query_params)
    ActiveRecord::Base.transaction do
      created_query = create!(query_params)
      created_query.update_or_create_query_results
    end
  end

  def update_or_create_query_results
    google_results = GoogleLinksSearcher.new.run_query(searched_quote)
    google_results.each do |google_result|
      QueryResult.create_or_update_result(id, google_result)
    end
    self
  end
end

class Query < ApplicationRecord
  has_many :query_results, dependent: :destroy


  def self.create_with_results(query_params)
    ActiveRecord::Base.transaction do
      google_results = GoogleLinksSearcher.new.call(query_params[:query])
      query = self.create!(query_params)
      query.update_or_create_query_results(google_results)
    end
  end

  def update_or_create_query_results(google_results = nil)
    google_results = GoogleLinksSearcher.new.call(self.query) if google_results.nil?
    google_results.each do |google_result|
      QueryResult.create_or_update_result(self.id, google_result)
    end
    self
  end

end

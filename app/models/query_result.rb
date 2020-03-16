class QueryResult < ApplicationRecord
  belongs_to :search_query, required: true

  def self.create_or_update_by_link!(search_query_id:, text:, link:)
    search_query = SearchQuery.find(search_query_id)
    query_result = find_by_search_query_id_and_link(search_query, link)
    if query_result.present?
      query_result.update!(text: text)
      query_result
    else
      create!(search_query_id: search_query_id, text: text, link: link)
    end
  end
end

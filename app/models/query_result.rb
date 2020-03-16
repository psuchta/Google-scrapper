class QueryResult < ApplicationRecord
  belongs_to :query, required: true

  def self.create_or_update_by_link!(query_id:, text:, link:)
    query = ::Query.find(query_id)
    query_result = find_by_query_id_and_link(query, link)
    if query_result.present?
      query_result.update!(text: text)
      query_result
    else
      create!(query_id: query_id, text: text, link: link)
    end
  end
end

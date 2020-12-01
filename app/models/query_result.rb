class QueryResult < ApplicationRecord
  belongs_to :search_query, required: true, counter_cache: true

  def self.create_or_update_by_link(search_query_id:, text:, link:)
    query_result = find_by_search_query_id_and_link(search_query_id, link)
    if query_result.present?
      query_result.update(text: text)
    else
      create(search_query_id: search_query_id, text: text, link: link)
    end
  end
end

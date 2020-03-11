class QueryResult < ApplicationRecord
  belongs_to :query, required: true

  def self.create_or_update_result(query_id:, text:, link:)
    query_result = where(query_id: query_id, link: link).first
    if query_result.present?
      query_result.update(text: text)
    else
      create!(query_id: query_id, text: text, link: link)
    end
  end
end

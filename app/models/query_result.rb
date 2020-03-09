class QueryResult < ApplicationRecord
  belongs_to :query

  def self.create_or_update_result(query_id, text,link)
    query_result = self.where(query_id: query_id, link: link).first
    if query_result.present?
      query_result.update(text: text, updated_at: Time.now)
    else
      self.create!(query_id: query_id, text: text, link: link)
    end
  end
end

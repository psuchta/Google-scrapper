class QueryResult < ApplicationRecord
  belongs_to :query

  def self.create_or_update_result(query_id, query_result_params)
    url = query_result_params[:url]
    text = query_result_params[:text]
    query_result = self.where(query_id: query_id, link: url).first
    if query_result.present?
      query_result.update(text: text, updated_at: Time.now)
    else
      self.create!(query_id: query_id, text: text, link: url)
    end
  end
end

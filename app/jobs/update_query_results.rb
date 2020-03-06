class UpdateQueryResults < Struct.new(:query_id)

  def perform
    query = Query.find_by(id:query_id)
    return unless query.present?
    query.update_or_create_query_results
  end

end

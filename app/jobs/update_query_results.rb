# class UpdateQueryResults < ApplicationJob
#   queue_as :default

#   # after_perform do |job|
#   #   self.class.set(wait: 10.seconds).perform_later(job.arguments.first)
#   # end

#   def preform(query_id)
#     Rails.logger.debug "[Before find] [#{self.class}] [#{job_id}] #{e}"
#     query = Query.find_by(query_id)
#     Rails.logger.debug "[After find] [#{self.class}] [#{job_id}] #{e}"
#     return unless query.present?
#     query.update_or_create_query_results
#     Rails.logger.debug "[Return] [#{self.class}] [#{job_id}] #{e}"
#   end
# end


class UpdateQueryResults < Struct.new(:query_id)

  def perform
    query = Query.find_by(id:query_id)
    return unless query.present?
    query.update_or_create_query_results
  end

end

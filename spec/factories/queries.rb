FactoryBot.define do
  factory :query do
    searched_quote { Faker::Lorem.paragraph(sentence_count: 1) }

    factory :query_with_query_results do
      transient do
        query_results_count { 3 }
      end

      after(:build) do |query, evaulator|
        create_list(:query_result, evaulator.query_results_count, query: query)
      end
    end
  end
end

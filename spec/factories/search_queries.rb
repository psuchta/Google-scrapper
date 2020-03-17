FactoryBot.define do
  factory :search_query do
    searched_quote { Faker::Lorem.paragraph(sentence_count: 1) }

    factory :search_query_with_query_results do
      transient do
        query_results_count { 3 }
      end

      after(:build) do |search_query, evaulator|
        create_list(:query_result, evaulator.query_results_count, search_query: search_query)
      end
    end
  end
end

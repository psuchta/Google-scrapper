FactoryBot.define do
  factory :query_result do
    search_query
    text { Faker::Lorem.paragraph(sentence_count: 1) }
    link { Faker::Internet.url }
  end
end

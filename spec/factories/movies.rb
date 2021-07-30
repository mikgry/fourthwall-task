FactoryBot.define do
  factory :movie do
    sequence(:omdb_id) { |n| "tt111334#{n}" }

    trait :synced do
      omdb_synced { true }
      title { "Title" }
      description { "plot" }
      runtime { "100 minutes" }
      released_at { 1.year.ago }
      imdb_rating { BigDecimal("10") }
    end
  end
end

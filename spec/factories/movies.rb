FactoryBot.define do
  factory :movie do
    sequence(:omdb_id) { |n| "tt111334#{n}" }

    trait :synced do
      omdb_synced { true }
    end
  end
end

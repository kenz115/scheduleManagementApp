FactoryBot.define do
  factory :schedule do
    sequence(:title) { |n| "勉強#{n}" }
    start_date { "3021-5-22" }
    end_date { "3021-5-23" }
    all_day { true }
    memo { "メモ" }

    trait :edit_schedule do
      sequence(:title) { |n| "食事#{n}" }
      start_date { "3021-5-22" }
      end_date { "3021-5-23" }
      all_day { true }
      memo { "メモ" }
    end

    trait :over_characters do
      title { "タイトルタイトルタイトルタイトルタイトルタ" }
      memo { "メモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメモメ" }
    end

    trait :error_date do
      start_date { "2021-5-21" }
      end_date { "2021-5-20" }
    end
  end
end

FactoryBot.define do
  factory :item do
    title            { 'タイトル' }
    text             { 'テキスト' }
    category_id      { 1 }
    condition_id     { 1 }
    shipping_cost_id { 1 }
    prefecture_id    { 1 }
    arrival_date_id  { 1 }
    price            { 300 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

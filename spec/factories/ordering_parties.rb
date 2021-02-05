FactoryBot.define do
  factory :ordering_party do
    token {"tok_abcdefghijk00000000000000000"}
    post_number   { '123-4567' }
    prefecture_id { 1 }
    city          { '横浜市緑区' }
    house_number  { '青山1-1-1' }
    phone_number  { '09012345678' }
    user_id       { 1 }
    item_id       { 1 }
  end
end

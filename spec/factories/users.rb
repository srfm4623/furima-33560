FactoryBot.define do
  factory :user do
    nickname              { 'フリマ太郎' }
    email                 { 'test@test.com' }
    password              { 'AAaa11' }
    password_confirmation { password }
    last_name             { '太郎' }
    first_name            { '山田' }
    last_name_reading     { 'タロウ' }
    first_name_reading    { 'ヤマダ' }
    date                  { '2021-01-01' }
  end
end

require 'factory_bot_rails'

FactoryBot.define do
  factory :category do
    name { 'Tecnologia' }
    url { 'http://localhost:3000/api/v1/categories/1' }
  end

end
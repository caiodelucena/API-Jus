require 'factory_bot_rails'

FactoryBot.define do
  factory :category do
    name { 'Tecnologia' }
    url { 'http://localhost:3000/api/v1/categories/1' }
  end

  factory :article do 
    title { 'Sed pretium rhoncus nibh a rhoncus.' }
    active { true }
    category_id { 1 }
  end

  factory :page do
    number { 1 }
    content { 'Sed pretium rhoncus nibh a rhoncus. Proin hendrerit tellus' }
    article_id { 1 }
  end
end
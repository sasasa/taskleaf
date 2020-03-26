FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'RSpec＆Capybara＆FactoryBotを準備する' }
    user
    project
  end
end

# bin/rails g factory_bot:model task

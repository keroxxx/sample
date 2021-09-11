FactoryBot.define do
  factory :user do
    name { "Example User" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
    activated_at { Time.zone.now }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/default.png')) }
  end

  trait :admin do
    admin { true }
  end

  trait :no_activated do
    activated { false }
    activated_at { nil }
  end

  trait :with_microposts do
    after(:create) { |user| create_list(:micropost, 5, user: user)}
  end
end

FactoryBot.define do
  factory :status do
    current_status { "UP" }
  end

  factory :status_message do
    description { "Hello i'm a description" }
  end

  factory :user do
    email { "pigdog@email.com" }
    password "password"
    password_confirmation "password"
  end
end

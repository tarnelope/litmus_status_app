FactoryBot.define do
  factory :status do
    current_status { "UP" }
  end

  # This will use the User class (Admin would have been guessed)
  factory :status_message do
    description { "Hello i'm a description" }
  end
end

Fabricator(:user) do
  username { Faker::Name.first_name }
  email { |attrs|
    Faker::Internet.email([attrs[:username], sequence(:user_id)].join(' '))
  }
  password { Faker::Lorem.sentence }
  password_confirmation { |attrs| attrs[:password] }
  role :admin
end

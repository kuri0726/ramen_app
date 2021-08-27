User.create!(name:  "RamenMaster",
  email: "kuri0726@outlook.jp",
  password:              "1234Qa",
  password_confirmation: "1234Qa",
  admin:     true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "1234Aa"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
  end
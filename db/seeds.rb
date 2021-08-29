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

Store.create!(name: "ラーメン一郎　本店")
Store.create!(name: "麵屋　美味")
Store.create!(name: "蒙古ラーメン橋本")
Store.create!(name: "麵処　唯我独尊")
Store.create!(name: "ラーメンデパート　新宿店")
Store.create!(name: "麵屋　おお田")
Store.create!(name: "香港飯店")
Store.create!(name: "らーめん改")
Store.create!(name: "天下一")
Store.create!(name: "相田家")
Store.create!(name: "かっちゃんらーめん")
Store.create!(name: "麵屋　たに本")
Store.create!(name: "麵屋　くり田")
Store.create!(name: "吉本家")
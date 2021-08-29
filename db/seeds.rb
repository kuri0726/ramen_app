User.create!(name:  "RamenMaster",
  email: "kuri0726@outlook.jp",
  password:              "1234Qa",
  password_confirmation: "1234Qa",
  admin:     true)

99.times do |n|
  name  = Faker::App.name
  email = "example-#{n+1}@example.org"
  password = "1234Aa"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end

50.times do |n|
  day_of_week = ["日","月","火","水","木","金","土"]
  name = ["ラーメン一郎", "麵屋 おお林", "蒙古ラーメン", "麵処 あらし", "ラーメンデパート", "らーめん改", "相田家", "天下一", "かっちゃんらーめん", "吉本家", "麵処 くり田", "麵処 sin", "麵屋 せん川"]
  menus = ["つけめん 小 180g/￥900 並 220g/￥980 中 330g/￥1080",
            "大 440g/￥1200 特 550g/￥1350",
            "中華そば 並 180g/￥880 中 260g/￥980 大 360g/￥1100 特 460g/￥1250",
            "しょうゆらぁ麺1300円",
            "わんたん入りしょうゆらぁ麺1580円",
            "しょうゆチャーシュー麺1700円",
            "わんたん入りしょうゆチャーシュー麺1980円",
            "しおらぁ麺1300円",
            "わんたん入りしおらぁ麺1580円",
            "しおチャーシュー麺1700円",
            "わんたん入りしおチャーシュー麺1980円",
            "つけ麺(醤油・塩)1800円",
            "煮干しそば 白醤油 700円",
            "煮干しそば 黒醤油 700円",
            "濃厚煮干そば 800円(大盛不可)",
            "中華そば 800円(特製は少し厚めの低温チャー3枚と味玉半玉)",
            "牡蠣そば 900円(特製は牡蠣が4個と低温チャー1枚と味玉半玉・大盛不可)",
            "煮干つけ麺 980円",
            "煮干油そば 780円(スープ付き)"]

  name = "#{name[rand(13)]} #{Faker::Address.city}店"
  address = "#{Faker::Address.state} #{Faker::Address.city} #{Faker::Address.street_address}"
  telephone_number = "0#{rand(10)}#{rand(10)}#{rand(10)}-#{rand(10)}#{rand(10)}-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
  business_hours = "#{rand(10..12)}:00 ~ #{rand(18..24)}:00"
  holiday = "#{day_of_week[rand(7)]}曜日"
  menu = "#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}"
  Store.create!(name: name,
                address: address,
                telephone_number: telephone_number,
                business_hours: business_hours,
                holiday: holiday
                menu: menu)
end
User.create!(name:  "RamenMaster",
  email: "kuri0726@outlook.jp",
  password:              "1234Qa",
  password_confirmation: "1234Qa",
  image: "/default_icon.jpg",
  admin:     true)

99.times do |n|
  name  = Faker::App.name
  email = "example-#{n+1}@example.org"
  password = "1234Aa"
  image = "/user_image/S__#{rand(35340342..35340361)}.jpg"

  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      image:            image)
end

50.times do |n|
  day_of_week = ["日","月","火","水","木","金","土"]
  names = [["ラーメン一郎", "らーめん いちろう"],
          ["麵屋 おお林", "めんや おおばやし"],
          ["蒙古ラーメン", "もうこらーめん"], 
          ["麵処 あらし", "めんどころ あらし"], 
          ["ラーメンデパート", "らーめんでぱーと"], 
          ["らーめん改", "らーめんかい"], 
          ["相田家", "あいだや"], 
          ["天下一", "てんかいち"], 
          ["かっちゃんらーめん", "かっちゃんらーめん"], 
          ["吉本家", "よしもとや"], 
          ["麵処 くり田", "めんどころ くりた"], 
          ["麵処 sin", "めんどころ しん"], 
          ["麵屋 せん川", "めんどころ せんがわ"]]

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

  random_number = rand(13)

  store_name = "#{names[random_number][0]} #{Faker::Address.city}店"
  address = "#{Faker::Address.state} #{Faker::Address.city} #{Faker::Address.street_address}"
  telephone_number = "0#{rand(10)}#{rand(10)}#{rand(10)}-#{rand(10)}#{rand(10)}-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
  business_hours = "#{rand(10..12)}:00 ~ #{rand(20..24)}:00"
  holiday = "#{day_of_week[rand(7)]}曜日"
  menu = "#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}\n#{menus[rand(19)]}"
  store_kana = "#{names[random_number][1]}"

  Store.create!(name: store_name,
                address: address,
                telephone_number: telephone_number,
                business_hours: business_hours,
                holiday: holiday,
                menu: menu,
                kana: store_kana)
end

100.times do |n|
  SelectScore.create!(select_score: 100-n)
end

61.times do |n|
  SelectTime.create!(select_time: 5*n)
end

2.times do |n|
  week = ["平日", "土日"]
  Week.create!(select_week: week[n], week_number: n)
end

24.times do |n|

  between = "#{n}時台"
  
  time = Time.new(2021, 01, 01, 00, 00, 00, '+00:00')
  from_to = time +  1 * n.hours
  
  FromTo.create!(between: between, from_to: from_to)
end

600.times do |n|
  menus = ["つけめん 小 180g/￥900 並",
    "中華そば 中 260g/￥980",
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
    "中華そば 800円",
    "牡蠣そば 900円",
    "煮干つけ麺 980円",
    "煮干油そば 780円(スープ付き)"]

  contents = ["スープ：前面にくる魚介の風味と動物系の深みのある旨み。

    麺：自家製太麺。麺だけ啜ると、コシがあって小麦の風味がたちます。スープとの絡みもほどよく、追加の辛味の味変も楽しんでいたら、麺はなくなってしまいました。
    具材：チャーシュー、メンマ、ナルト、ネギm(__)m、のりm(__)m、味玉m(__)m。どれも安定して安心の旨さ。
    
    最後にスープ割を柚子ありで、余韻を楽しみながら、美味しく完食。
    やはり間違いないですね、ごちそうさまでした。",

    "スープは、ドロンジョ豚骨魚介醤油味。
    濃厚だがくどくない素材の良さを感じる
    
    麺は極太喰らうストレート。
    小麦感しっかりな上質なもの
    
    TOKYOXのチャーシュー、メンマ、ねぎ
    
    こだわりはさすがのもの。
    何より富田店主の魅せる時間が良い",

    "麺の太さ、つけ汁の濃厚さ、突き詰め過ぎてここまでやるとやり過ぎかとも思えるが、それでも食べれば納得のおいしさ。
    個人的にはチャーシューよりも、焼売とまかないご飯が絶品でした。",
    
    "麺の太さ、つけ汁の濃厚さ、突き詰め過ぎてここまでやるとやり過ぎかとも思えるが、それでも食べれば納得のおいしさ。
    個人的にはチャーシューよりも、焼売とまかないご飯が絶品でした。

    スープ：前面にくる魚介の風味と動物系の深みのある旨み。

    麺：自家製太麺。麺だけ啜ると、コシがあって小麦の風味がたちます。スープとの絡みもほどよく、追加の辛味の味変も楽しんでいたら、麺はなくなってしまいました。
    具材：チャーシュー、メンマ、ナルト、ネギm(__)m、のりm(__)m、味玉m(__)m。どれも安定して安心の旨さ。
    
    最後にスープ割を柚子ありで、余韻を楽しみながら、美味しく完食。
    やはり間違いないですね、ごちそうさまでした。"]

  ate_food = menus[rand(17)]
  
  if n > 100
    date_from = Date.parse("2021/01/01")
    date_to   = Date.parse("2021/09/01")
    visit_date = Random.rand(date_from .. date_to)
  else
    date_from = Date.parse("2020/09/01")
    date_to   = Date.parse("2021/05/31")
    visit_date = Random.rand(date_from .. date_to)
  end

  score = rand(50..100)
  time_from = Time.new(2021, 01, 01, 10, 00, 00, '+00:00')
  time_to   = Time.new(2021, 01, 01, 23, 59, 59, '+00:00')
  visit_time = Random.rand(time_from .. time_to)
  waiting_time = "#{rand(13)}"+"5"
  store_number = rand(1..20)
  week = visit_date.to_time.wday

  if n > 100
    image = "S__#{rand(35323937..35324028)}.jpg"
  else
    image = "no_image.png"
  end

  Micropost.create!(ate_food: ate_food,
    visit_date: visit_date,
    visit_time: visit_time,
    score: score,
    waiting_time: waiting_time,
    user_id: rand(1..100),
    store_id: store_number,
    created_at: visit_date,
    micropost_image: image,
    week: week,
    content: contents[rand(0..3)])  
end

20.times do |n|
  store = Store.find_by(id: n+1)
  recent_microposts = Micropost.where(store_id: store.id).order(created_at: "DESC").limit(1)
  recent_micropost = recent_microposts[0]
  store.store_image.attach(io: File.open("public/seed_image/#{recent_micropost.micropost_image}"), filename: recent_micropost.micropost_image)
end

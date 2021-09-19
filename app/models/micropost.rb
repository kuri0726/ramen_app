class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_one_attached :store_image
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :store_id, presence: true
  validates :ate_food, presence: true, length: {maximum: 30}
  validates :visit_date, presence: { message: "を選択してください。" }
  validates :visit_time, presence: { message: "を選択してください。" }
  validates :score, presence: { message: "を選択してください。" }
  validates :waiting_time, presence: { message: "を選択してください。" }
  validates :content, presence: true
  
  def self.set_time(time)
    if time == "" || time.nil?
      all
    else
      to = time.to_time +  59.minutes + 59.seconds
      where(visit_time: "#{time}".."#{to}")
    end
  end

  def self.set_week(week)
    if week == "1"
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"])
    elsif week == "0"
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"])
    else
      all
    end
  end

  def self.microposts_counter(n)
    if n == 0
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"]).where(visit_time: "00:00:00".."09:59:59")
    elsif n == 1
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"]).where(visit_time: "00:00:00".."09:59:59")
    elsif n == 2
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"]).where(visit_time: "15:00:00".."17:59:59")
    elsif n == 3
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"]).where(visit_time: "15:00:00".."17:59:59")
    elsif n == 4
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"]).where(visit_time: "22:00:00".."23:59:59")
    elsif n == 5
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"]).where(visit_time: "22:00:00".."23:59:59")
    elsif n >= 6 && n < 11
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"]).where(visit_time: "#{n + 4}:00:00".."#{n + 4}:59:59")
    elsif n >= 11 && n < 16
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"]).where(visit_time: "#{n - 1}:00:00".."#{n - 1}:59:59")
    elsif n >= 16 && n < 20
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "1", "2", "3", "4", "5"]).where(visit_time: "#{n + 2}:00:00".."#{n + 2}:59:59")
    elsif n >= 20 && n < 24
      where([%(strftime('%w', visit_date) in (?) or strftime('%w', visit_date) in (?)), "0", "6"]).where(visit_time: "#{n - 4}:00:00".."#{n - 4}:59:59")
    end
  end

end

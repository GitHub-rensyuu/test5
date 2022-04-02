class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


# scope :スコープの名前, -> { 条件式 }
scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日

# 今週合計
from  = Time.current.at_beginning_of_day
to    = (from + 6.day).at_end_of_day
scope :created_week, -> { where(created_at: from...to) }


# 先週合計
to2    = (from + 13.day).at_end_of_day
scope :created_week2, -> { where(created_at: to...to2) }

end

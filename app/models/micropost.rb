class Micropost < ApplicationRecord
  belongs_to :user#ユーザーの紐づけなしではmicropostを保存できない

  validates :content, presence: true, length: { maximum: 255 }
end

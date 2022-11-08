class Micropost < ApplicationRecord
  belongs_to :user#ユーザーの紐づけなしではmicropostを保存できない

  validates :content, presence: true, length: { maximum: 255 }
  
  #favoritesの多対多の設定
  has_many:favorites
  has_many:likings,through: :favorites, source: :user

  
end

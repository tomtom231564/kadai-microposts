class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }#←バリテーション　nameは空はダメ、50文字以内
  validates :email, presence: true, length: { maximum: 255 },#←からは許さない、255文字まで
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },#,←正規表現でエラーが出ないようになっている
                    uniqueness: { case_sensitive: false }#←uniquenessは重複を許さない、case_sensitiveは大文字と小文字を区別しない
  has_secure_password
end

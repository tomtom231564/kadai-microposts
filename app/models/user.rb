class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }#←バリテーション　nameは空はダメ、50文字以内
  validates :email, presence: true, length: { maximum: 255 },#←からは許さない、255文字まで
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },#,←正規表現でエラーが出ないようになっている
                    uniqueness: { case_sensitive: false }#←uniquenessは重複を許さない、case_sensitiveは大文字と小文字を区別しない
  has_secure_password
  
  has_many :microposts#user側から見たときにmicropostsがたくさんあるのでhas_manyとなる
  
  #userからみてフォローしているuserはたくさんいるのでhas_many※中間テーブルとの関係
  has_many :relationships
  
  #has_many :followingsフォローしている人たちがおおい
  #followingsはモデルがないため　through sourceの記述が必要
  #through: :relationships　リレーションシップテーブルの　followのidだよといっている
  has_many :followings, through: :relationships, source: :follow
  
  #フォローされているとき自分は多になる「:reverses_of_relationship」は造語※
  #userからキーを参照するとuser_idになるのでforeign_keyでfollow_idだよといっている。
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  
  #has_many :followingsフォローしている人たちがおおい
  #followingsはモデルがないため　through sourceの記述が必要
  #中間テーブルのuserから見たときにfollowerがおおい
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  ##########フォローの関係を手軽に作成したり外したりする################################
  #フォローする
  def follow(other_user)
    unless self == other_user#自分じゃないかの確認

      #見つかれば、Relationshipモデル（クラス）のインスタンスを返します
      #見つからなければ、self.relationships.create(follow_id: other_user.id) として
      #フォロー関係を保存(create=build+save)します。
      #https://railsdoc.com/page/find_or_create_by
      #フォローしているときに重複してフォローしなくなる
      #self.relationshipsで自分のリレーションシップテーブルをみている
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  #アンフォロー
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    #リレーションシップがあれば、それを削除します。
    relationship.destroy if relationship
  end
  
  #フォローしているか確認メソッド
  def following?(other_user)
    #self.followingでフォローしている人たちを取得.include?でother_userがいるか確認
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  

end

class Relationship < ApplicationRecord
  belongs_to :user#モデル名_id の名前になっている user_id はRailsの方で自動的にUserを参照するようになっています
  belongs_to :follow, class_name: 'User'#follow_idは新設したので、Userクラスを使うと指定。あやまってFollowクラスをさんしょうしないため
end

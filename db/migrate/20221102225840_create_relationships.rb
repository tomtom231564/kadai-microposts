class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      #t.reference 参照させる
      #foreingn_key：外部キーとして参照する これをしないとテーブル内で参照項目をさがしちゃう
      t.references :user, null: false, foreign_key: true
      t.references :follow, null: false, foreign_key: { to_table: :users }
      t.timestamps

      t.index [:user_id, :follow_id], unique: true#user_idとfollow_idはペアで重複保存されない

    end
  end
end

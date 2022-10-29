class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.string :content
	    #null:falseはデータベースでは空の状態で保存させない
	    #presence: true はRailsの機能で空の状態で保存させないことであり、
	    #SQLでは保存できてしまいます
	    #foreign_keyは外部キー制約
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)#←メールアドレスに対して設定。メールアドレスを小文字にして暗号化したもの
    size = options[:size]#画像サイズ
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"#アバター画像URL
  end
end
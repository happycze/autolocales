class User < Sequel::Model
  one_to_many :user_dictionary

  def encoded_user_id
    (id+112345).to_s(36)
  end

  def self.encode_user_id(user_id)
    (user_id+112345).to_s(36)
  end

  def self.decode_user_id(user_id)
    user_id.to_i(36)-112345
  end

  # General authentication
  def self.authenticate(login, response, nonce)
    user = self.first(login: login)
    cached_nonce = Padrino.cache[nonce] # Ensure one time usage of nonce
    Padrino.cache.delete(nonce)

    user if user && (Digest::SHA256.hexdigest(cached_nonce+user.password)) == response
  end

  # After registration authentication
  def self.authenticate_registration(login, password)
    user = self.first(login: login)

    user if user && (user.password == password)
  end

  # After thirdparty authentication
  def self.authenticate_thirdparty(auth)
    user = self.first(login: auth["info"]["email"])
  end
end

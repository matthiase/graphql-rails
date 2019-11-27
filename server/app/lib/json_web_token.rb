class JsonWebToken
  def self.encode(payload)
    key = Rails.application.credentials.secret_key_base.byteslice(0..31)
    JWT.encode(payload, key)
  end

  def self.decode(token)
    key = Rails.application.credentials.secret_key_base.byteslice(0..31)
    HashWithIndifferentAccess.new(JWT.decode(token, key)[0])
  rescue
    nil
  end
end

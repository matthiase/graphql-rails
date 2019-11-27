module Types
  class LocalAuthenticationProvider < BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end

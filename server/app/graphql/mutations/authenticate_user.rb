module Mutations
  # Inherit directly from the GraphQL mutation class because this mutation should
  # skip the authentication checks included in the BaseMutation class.
  class AuthenticateUser < GraphQL::Schema::Mutation
    null true

    argument :authentication_provider, Types::LocalAuthenticationProvider, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(authentication_provider: nil)
      raise AuthenticationError if authentication_provider.blank?

      user = User.find_by!(email: authentication_provider[:email])
      unless user&.authenticate(authentication_provider[:password])
        raise AuthenticationError
      end

      {
        user: user,
        token: JsonWebToken.encode({user_id: user.id})
      }
    rescue ActiveRecord::RecordNotFound, AuthenticationError => e
       GraphQL::ExecutionError.new("Invalid credentials")
    end

  end
end

module Mutations
  # Inherit directly from the GraphQL mutation class because this mutation should
  # skip the authentication checks included in the BaseMutation class.
  class CreateUser < GraphQL::Schema::Mutation

    class AuthenticationProvider < GraphQL::Schema::InputObject
      argument :local, Types::LocalAuthenticationProvider, required: false
    end
    
    argument :name, String, required: true
    argument :authentication_provider, AuthenticationProvider, required: true

    type Types::UserType

    def resolve(name: nil, authentication_provider: nil)
      User.create!(
        name: name,
        email: authentication_provider&.[](:local)&.[](:email),
        password: authentication_provider&.[](:local)&.[](:password)
      )
    rescue ActiveRecord::RecordInvalid => e
       GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
    end

  end
end

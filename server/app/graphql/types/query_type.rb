module Types
  class QueryType < GraphQL::Schema::Object
    field :me, UserType, null: false do
      description "Returns the context's authenticated user"
    end
    def me
      authenticate!
      context[:authenticated_user]
    end

    field :user, UserType, null: false do
      description "Returns user matching the specified identifier"
      argument :id, ID, required: true
    end
    def user(id:)
      authenticate!
      User.find(id)
    end
    
    field :products, function: Resolvers::ProductSearch

    private

    def authenticate!
      raise GraphQL::ExecutionError, 'Not Authorized' unless context[:authenticated_user].present?
    end
  end
end

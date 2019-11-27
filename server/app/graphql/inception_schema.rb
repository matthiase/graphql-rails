class InceptionSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(error)
    # Add a top-level error to the response instead of returning nil
    raise GraphQL::ExecutionError, 'Not Authorized'
  end
end

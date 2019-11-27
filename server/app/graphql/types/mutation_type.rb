module Types
  class MutationType < GraphQL::Schema::Object
    field :create_user, mutation: Mutations::CreateUser
    field :authenticate_user, mutation: Mutations::AuthenticateUser
    field :create_product, mutation: Mutations::CreateProduct
    field :create_vote, mutation: Mutations::CreateVote
  end
end

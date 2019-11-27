module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :products, [ProductType], null: false
    field :votes, [VoteType], null: false
  end
end

module Types
  class VoteType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :product, ProductType, null: false
  end
end

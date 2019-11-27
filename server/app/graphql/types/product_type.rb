module Types
  class ProductType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :url, String, null: true
    field :created_by, UserType, null: false, method: :user
  end
end

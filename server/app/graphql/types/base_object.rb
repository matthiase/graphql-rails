module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

   # def self.authorized?(object, context)
   #   super && context[:authenticated_user].present?
   # end

  end
end

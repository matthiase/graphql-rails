module Mutations
  class CreateProduct < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :url, String, required: false

    type Types::ProductType

    def ready?(**args)
      if context[:authenticated_user].blank?
        raise GraphQL::ExecutionError, 'Not authorized'
      else
        true
      end
    end

    def resolve(name:, description:, url: nil)
      Product.create!(
        name: name,
        description: description,
        url: url,
        user: context[:authenticated_user]
      )
    rescue ActiveRecord::RecordInvalid => e
       GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
    end

  end
end

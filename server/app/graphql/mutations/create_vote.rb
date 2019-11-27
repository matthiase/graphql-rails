module Mutations
  class CreateVote < BaseMutation
    argument :product_id, ID, required: true

    type Types::VoteType

    def ready?(**args)
      if context[:authenticated_user].blank?
        raise GraphQL::ExecutionError, 'Not authorized'
      else
        true
      end
    end

    def resolve(product_id:)
      Vote.create!(
        product: Product.find(product_id),
        user: context[:authenticated_user]
      )
    rescue ActiveRecord::RecordInvalid => e
       GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
    end
  end
end

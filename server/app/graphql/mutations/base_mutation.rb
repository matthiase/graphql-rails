module Mutations
  class BaseMutation < GraphQL::Schema::Mutation

    #def ready?(**args)
    #  if context[:authenticated_user].blank?
    #    raise GraphQL::ExecutionError, 'Not authorized'
    #  else
    #    true
    #  end
    #end

  end
end

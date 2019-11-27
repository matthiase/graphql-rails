require 'search_object/plugin/graphql'

module Resolvers
  class ProductSearch
    include SearchObject.module(:graphql)

    scope { Product.all }

    type types[Types::ProductType]

    class ProductFilter < GraphQL::Schema::InputObject
      argument :OR, [self], required: false
      argument :name_contains, String, required: false
      argument :description_contains, String, required: false
    end

    option :filter, type: ProductFilter, with: :apply_filter
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip


    def apply_filter(scope, value)
      raise GraphQL::ExecutionError, 'Not Authorized' unless context[:authenticated_user].present?
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end


    def apply_first(scope, value)
      scope.limit(value)
    end


    def apply_skip(scope, value)
      scope.offset(value)
    end


    def normalize_filters(value, branches = [])
      scope = Product.all

      if value.include?(:name_contains)
        scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") 
      end

      if value.include?(:description_contains)
        scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") 
      end

      branches << scope

      # Recursively process or filters
      if value.include?(:or)
        value[:or].reduce(branches) { |memo, item| normalize_filters(item, memo) }
      end

      branches
    end

  end
end

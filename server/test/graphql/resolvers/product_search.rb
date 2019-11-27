require 'test_helper'

module Resolvers
  class ProductSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::ProductSearch.call(nil, args, nil)
    end

    def create_user
      User.create name: 'test', email: 'test@example.com', password: '123456'
    end

    def create_product(**attributes)
      Product.create! attributes.merge(user: create_user)
    end

    test 'filter option' do
      product1 = create_product name: 'Nintendo Switch', description: 'A gaming console', url: 'http://example.com/test1'
      product2 = create_product name: 'Super Soaker', description: 'A water gun', url: 'http://example.com/test2'
      product3 = create_product name: 'Duckworth Dog Toy', description: 'A dog toy that squeaks', url: 'http://example.com/test3'
      product4 = create_product name: 'The Road to GraphQL', description: 'A book for learning GraphQL', url: 'http://example.com/test4'

      result = find(
        filter: {
          description_contains: 'console',
          OR: [{
            name_contains: 'Soaker',
            OR: [{
              name_contains: 'Dog'
            }]
          }, {
            description_contains: 'water'
          }]
        }
      )

      assert_equalresult.map(&:description).sort,
        [product1, product2, product3].map(&:description).sort
    end
  end
end

require 'test_helper'

class Mutations::CreateProductTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateProduct.new(object: nil, context: { authenticated_user: user })
      .resolve(args)
  end

  def create_user
    User.create name: 'test', email: 'test@example.com', password: '123456'
  end

  test 'create a new product' do
    product = perform(
      name: 'Product name',
      description: 'Product description',
      user: create_user
    )

    assert product.persisted?
    assert_equal product.name, 'Product name'
    assert_equal product.description, 'Product description'
  end
end

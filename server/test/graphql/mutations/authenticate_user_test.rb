require 'test_helper'

class Mutations::AuthenticateUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::AuthenticateUser.new(object: nil, context: { session: {} }).resolve(args)
  end

  def create_user
    User.create!(
      name: 'Test User',
      email: 'email@example.com',
      password: '[omitted]',
    )
  end

  test 'success' do
    user = create_user

    result = perform(
      authentication_provider: {
        email: user.email,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure because no credentials' do
    response = perform
    assert_instance_of(GraphQL::ExecutionError, response)
    assert_equal response.message, "Invalid credentials"
  end

  test 'failure because wrong email' do
    create_user
    response = perform(authentication_provider: { email: 'wrong' })
    assert_instance_of(GraphQL::ExecutionError, response)
    assert_equal response.message, "Invalid credentials"
  end

  test 'failure because wrong password' do
    user = create_user
    response = perform(authentication_provider: { email: user.email, password: 'wrong' })
    assert_instance_of(GraphQL::ExecutionError, response)
    assert_equal response.message, "Invalid credentials"
  end
end

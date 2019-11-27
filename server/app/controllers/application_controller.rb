class ApplicationController < ActionController::API
  attr_reader :authenticated_user

  protected

  def authenticate_request
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    decoded_token = JsonWebToken.decode(token)
    if decoded_token && decoded_token[:user_id]
      @authenticated_user = User.find(decoded_token[:user_id])
    end
    @authenticated_user
  end

  def authenticate_request!
    authenticate_request
    raise 'Not autorized' if @authenticated_user.blank?
    @authenticated_user
  end

end

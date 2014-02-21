class CallbacksController < ApplicationController

	def fitbit
		@user = User.create token: params["oauth_token"], email: rand(36).to_s
		sign_in_and_redirect @user
	end

end

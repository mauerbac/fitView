class CallbacksController < ApplicationController

	def fitbit
		oauth_hash = request.env['omniauth.auth']
		consumer = OAuth::Consumer.new(ENV['appid'], ENV['appsecret'], site: "https://api.fitbit.com")
		token = OAuth::AccessToken.from_hash(consumer, { oauth_token: oauth_hash['credentials']['token'], oauth_token_secret: oauth_hash['credentials']['secret']})

		response = token.get("https://api.fitbit.com/1/user/-/profile.json")
		fitbit_id = JSON.parse(response.body)['user']['encodedId']

		@user = User.find_or_create_by fitbit_id: fitbit_id
		@user.update_attributes token: oauth_hash['credentials']['token'], secret: oauth_hash['credentials']['secret']

		sign_in_and_redirect @user
	end

end

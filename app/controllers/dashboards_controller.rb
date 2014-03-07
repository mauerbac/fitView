class DashboardsController < ApplicationController
	before_filter :authenticate_user!
	def index

	end

	def show
		consumer = OAuth::Consumer.new(ENV['appid'], ENV['appsecret'], site: "https://api.fitbit.com")
		token = OAuth::AccessToken.from_hash(consumer, { oauth_token: current_user.token, oauth_token_secret: current_user.secret })

		steps = JSON.parse(token.get('http://api.fitbit.com/1/user/-/activities/date/2014-02-17.json').body)['summary']['steps']
		@steps = steps
	end
end

class DashboardsController < ApplicationController
	before_filter :authenticate_user!
	def index

	end

	def show
		consumer = OAuth::Consumer.new(ENV['appid'], ENV['appsecret'], site: "https://api.fitbit.com")
		token = OAuth::AccessToken.from_hash(consumer, { oauth_token: current_user.token, oauth_token_secret: current_user.secret })

		#Get user info

		response = token.get("https://api.fitbit.com/1/user/-/profile.json")
		json = JSON.parse(response.body)
		@name=json['user']['displayName']


		#get current date
		time= Time.now
		cur_date=time.strftime("%Y-%d-%m")

		#------ Override for testing ------ 
		cur_date="2014-02-17"
		#-------------------------------


		json = JSON.parse(token.get('http://api.fitbit.com/1/user/-/activities/date/' + cur_date+ '.json').body)
		
		stepGoal=json['goals']['steps']
		cur_steps=json['summary']['steps']

		
		#This data could be super cool and isn't offered on Fitbit dashbaord. (besides very active mins)
		cur_fairlyActive= json['summary']['fairlyActiveMinutes']
		cur_lightlyActive= json['summary']['lightlyActiveMinutes']
		cur_veryActive= json['summary']['veryActiveMinutes']
		cur_sedentaryMins= json['summary']['sedentaryMinutes']

		#we should check if greater than 1
		@stepsRemain= stepGoal-cur_steps
		@steps = cur_steps




	end
end

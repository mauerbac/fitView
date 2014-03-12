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


		#------ Override for testing ------ 
		# cur_date="2014-02-17"
		@date_today = Date.today.to_s
		@date_one_days_ago= (Date.today - 1.days).to_s
		@date_two_days_ago = (Date.today - 2.days).to_s
		@date_three_days_ago = (Date.today - 3.days).to_s
		@date_four_days_ago = (Date.today - 4.days).to_s
		@date_five_days_ago = (Date.today - 5.days).to_s
		@date_six_days_ago = (Date.today - 6.days).to_s
		@date_seven_days_ago = (Date.today - 7.days).to_s
		#-------------------------------

		#-------------- Gets steps for past seven days ----------	
		@json = JSON.parse(token.get('http://api.fitbit.com/1/user/-/activities/date/' + @date_today + '.json').body)
		
		@steps_past_seven_days_json = JSON.parse(token.get('http://api.fitbit.com/1/user/-/activities/steps/date/today/7d.json').body)
		
		 @step_goal= @json['goals']['steps']
		 @step_count = @json['summary']['steps']

		
		# #This data could be super cool and isn't offered on Fitbit dashbaord. (besides very active mins)
		# cur_fairly_active_minutes= json['summary']['fairlyActiveMinutes']
		# cur_lightly_active_minutes= json['summary']['lightlyActiveMinutes']
		# cur_very_active_minutes= json['summary']['veryActiveMinutes']
		# cur_sedentary_minutes= json['summary']['sedentaryMinutes']

		# #we should check if greater than 1
		# # @steps_remain= (@step_goal- @cur_steps)
		

		# respond_to do |format|
		# 	format.html
		# 	format.json {render json: json}
		# end

	end
end

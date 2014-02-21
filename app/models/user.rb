class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable	
  devise :omniauthable, :omniauth_providers => [:fitbit]

  
end

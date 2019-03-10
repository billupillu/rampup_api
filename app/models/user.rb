class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_many :uploads
  
	

	def g_token(name=nil)
		o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
		tkn = (0...50).map { o[rand(o.length)] }.join
		if name.nil?
			name = self.email.split('@').first
		end	
		self.update_attributes(token: tkn, name: name)
	end
end

class User < ActiveRecord::Base
	has_many :friendships
	has_many :friends, through: :friendships
	has_many :messages
	has_many :comments

	validates :first_name, 		:presence 	=> true,
			  :length 						=> { :within => 2..50 }
	
	validates :last_name, 		:presence 	=> true,
			  :length 						=> { :within => 2..50 }
	
	validates :email, 	:presence 	=> true,
			  :length 						=> { :maximum => 50 }
	
	attr_accessor :password
	validates :password, 		:presence 	=> true,
			  :confirmation 				=> true,
			  :length 						=> { :within => 6..50 }
  	
  	# validates :confirm_password, :presence => true

	before_save :encrypt_password

	private def encrypt_password
		self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}}") if self.new_record?
		# SHA2 encryption type 
		# creates a  new encrypted key and stores it into the salt (self.salt)

		# encrypt the password and store that in the ecrypted_password field
		self.encrypted_password = encrypt(password)
	end

	# encrypt the password using both the salt and the passed password
	def encrypt(pass)
		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
	end


	def self.authenticate(email, submitted_password)
		user = User.find_by(email: email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
end
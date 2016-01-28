class User < ActiveRecord::Base

	validates :username, presence: true, uniqueness: true

	has_many :posts, foreign_key: :author_id
	has_many :paintings, foreign_key: :owner_id


	def password
		@password ||= BCrypt::Password.new(password_digest)
	end

	def password=(new_password)
		@password = BCrypt::Password.create(new_password)
		self.password_digest = @password
	end

	def authenticate?(pword)
		password == pword
	end

	def owns?(object)
		id == object.id
	end
end

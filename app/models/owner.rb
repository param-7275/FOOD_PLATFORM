class Owner < User
	has_secure_password
	has_one :restaurant , dependent: :destroy
end

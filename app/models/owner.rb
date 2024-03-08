class Owner < User
  	has_one :restaurant , dependent: :destroy
  # def initialize(attributes = nil)
  #   super(attributes.except(:password, :password_confirmation))
  # end
end

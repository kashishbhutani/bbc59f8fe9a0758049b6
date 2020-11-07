class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Model Schema
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String

  # Validations
  validates :first_name, :last_name, :email, presence: true
end

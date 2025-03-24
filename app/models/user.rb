class User < ApplicationRecord
  before_create :generate_api_token
  before_save :generate_api_token, if: :reset_api_token?

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable

  attribute :reset_api_token, :boolean, default: :false

  validates :email, presence: true, uniqueness: true

  private

  def generate_api_token
    self.api_token ||= SecureRandom.hex(20)
  end
end

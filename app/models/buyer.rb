class Buyer < ApplicationRecord
  has_many :orders

  validates :name, :email, :telephone, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end

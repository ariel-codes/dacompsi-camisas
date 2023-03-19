class Buyer < ApplicationRecord
  has_many :orders, dependent: :restrict_with_exception
  has_many :emails, class_name: "Ahoy::Message", as: :user, dependent: :destroy

  validates :name, :email, :telephone, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_format_of :telephone, with: /\A\d{2} \d{5}-\d{4}\z/
end

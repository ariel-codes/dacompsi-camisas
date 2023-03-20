class Buyer < ApplicationRecord
  has_many :visits, class_name: "Ahoy::Visit"

  has_many :orders, dependent: :restrict_with_exception
  has_many :emails, class_name: "Ahoy::Message", as: :user, dependent: :destroy

  validates :name, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP, allow_blank: false}, uniqueness: {case_sensitive: false}
  validates :telephone, format: {with: /\A\d{2}\d{9}\z/, allow_blank: false}, uniqueness: true
end

class User < ActiveRecord::Base
  include Users::MagickColumns
  include Users::Roles

  has_paper_trail

  attr_accessor :login

  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :username, :email, length: { maximum: 255 }, allow_nil: true,
    allow_blank: true

  has_many :locations

  def to_s
    self.username
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(
        'lower(username) = :value OR lower(email) = :value',
        value: login.downcase
      ).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end

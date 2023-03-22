class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  belongs_to :role

  def self.anonymized_view?(ip_address = nil)
    # anonymized_view_starter_ips = $redis.get('anonymized_view_starter_ips') || ''
    return true if ip_address && anonymized_view_starter_ips.include?(ip_address)

    false
  end

  def name(ip_address = nil)
    User.anonymized_view?(ip_address) ? role.name + ' ' + id.to_s : self[:name]
  end

  def fullname(ip_address = nil)
    User.anonymized_view?(ip_address) ? role.name + ', ' + id.to_s : self[:fullname]
  end

  def first_name(ip_address = nil)
    User.anonymized_view?(ip_address) ? role.name : fullname.try(:[], /,.+/).try(:[], /\w+/) || ''
  end

  def email(ip_address = nil)
    User.anonymized_view?(ip_address) ? role.name + '_' + id.to_s + '@mailinator.com' : self[:email]
  end
end

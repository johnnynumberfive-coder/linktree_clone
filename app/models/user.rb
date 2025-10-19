class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :links, dependent: :destroy
  after_create :create_default_links
  after_update :create_default_links

  friendly_id :username, use: %i[slugged]

  validates :full_name, length: { maximum: 25 }
  validates :body, length: {maximum: 80 }
  validate :valid_ussername

  def valid_ussername
    errors.add(:username, "is already taken") if User.exists?(username: username)

    restricted_username_list = %[admin root dashboard analytics appearance setting preferences calendar]

    errors.add(:username, "is restricted") if restricted_username_list.include?(username)
  end

  def should_generate_new_friendly_id?
    username_changed? || slug.blank?
  end

  private

  def create_default_links
    Link.create(user: self, title: '', url: '') while links.count < 5
  end
end

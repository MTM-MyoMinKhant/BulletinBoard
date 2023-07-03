class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  belongs_to :create_user, class_name: 'User', optional: true
  belongs_to :updated_user, class_name: 'User', optional: true
  belongs_to :deleted_user, class_name: 'User', optional: true
  has_many :posts, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["name", "email" , "dob"] # Add any other attributes you want to make searchable
  end
  validates :name, presence: true 
  validates :email, presence: true , uniqueness: true
  validates :password , presence: true , confirmation: true
  validates :phone, presence: true , numericality: { message: "must be a number" }
  validates :dob, presence: true 
  validates :address, presence: true 
  validates :avatar, format: { with: /\.(png|jpg|jpeg|gif|avif|webp|jfif)\z/i, message: "only images files are allowed" }, allow_blank: true
end

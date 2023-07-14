class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader
  belongs_to :create_user, class_name: 'User', optional: true
  belongs_to :updated_user, class_name: 'User', optional: true
  belongs_to :deleted_user, class_name: 'User', optional: true

  def self.ransackable_attributes(auth_object = nil)
    ["name", "email" , "dob" ] # Add any other attributes you want to make searchable
  end
  validates :name, presence: true , on: [:create , :update]
  validates :email, presence: true , uniqueness: true , on: [:create , :update]
  validates :password , presence: true , confirmation: true ,on: [:create , :password_update]
  validates :phone, presence: true , numericality: { message: "must be a number" }
  validates :dob, presence: true , on: [:create , :update]
  validates :address, presence: true , on: [:create , :update]
  validates :avatar, format: { with: /\.(png|jpg|jpeg|gif|avif|webp|jfif)\z/i, message: "only images files are allowed" }, allow_blank: true
end

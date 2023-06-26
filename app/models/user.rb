class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :create_user, class_name: 'User', optional: true
  belongs_to :updated_user, class_name: 'User', optional: true
  belongs_to :deleted_user, class_name: 'User', optional: true
  has_many :posts, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["name", "email" , "dob"] # Add any other attributes you want to make searchable
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true 
  validates :phone, presence: true , numericality: { message: "must be a number" }
  validates :dob, presence: true 
  validates :address, presence: true 
  validates :avatar, format: { with: /\.(png|jpg|jpeg|gif)\z/i, message: "only allows PNG, JPG, JPEG, and GIF images" }
end

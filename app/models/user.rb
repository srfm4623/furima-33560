class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do       
    validates :nickname           
    validates :last_name,          format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "Full-width characters." }
    validates :first_name,         format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "Full-width characters." }
    validates :last_name_reading,  format: { with: /\A[ァ-ン]/, message: "Full-width katakana characters." }
    validates :first_name_reading, format: { with: /\A[ァ-ン]/, message: "Full-width katakana characters." }
    validates :date
  end
  validates :password,            format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,message: " Include both letters and numbers" } #半角英数字混合
end

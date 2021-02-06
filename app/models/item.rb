class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :arrival_date
  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: true do
    validates :image
    validates :title
    validates :text
    validates :price
  end

  with_options numericality: { other_than: 0, message: 'select' } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :arrival_date_id
  end

  validates :price, format: { with: /\A\d{3,7}+\z/, message: 'half-width numbers' }

  validates :price, Inclusion: { in: 300..9_999_999, message: 'outside the limits' }
end

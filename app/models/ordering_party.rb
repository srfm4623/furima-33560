class OrderingParty
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number,
                :order_id, :price, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_number,   format: { with: /\A\d{3}-\d{4}\z/, message: 'input correctly' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'select' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'input only number' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end

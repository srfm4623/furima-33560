class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :same_params, only: [:index, :create]
  before_action :user_guidance, only: :index

  def index
    @ordering_party = OrderingParty.new
  end

  def create
    @ordering_party = OrderingParty.new(ordering_party_params)
    if @ordering_party.valid?
      pay_item
      @ordering_party.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def same_params
    @item = Item.find(params[:item_id])
  end

  def user_guidance
    return redirect_to root_path if current_user == @item.user || @item.order.present?
  end

  def ordering_party_params
    params.require(:ordering_party).permit(:post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, price: @item.price, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: ordering_party_params[:price], # 商品の値段
      card: ordering_party_params[:token],   # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end

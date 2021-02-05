class OrdersController < ApplicationController
  before_action :same_params, only: [:index, :create]
  before_action :seller_identification, only: :index

  def index
    # @item = Item.find(params[:item_id])
    @ordering_party = OrderingParty.new
  end

  def create 
    # @item = Item.find(params[:item_id])
    # binding.pry
    @ordering_party = OrderingParty.new(ordering_party_params)
    if @ordering_party.valid?
      pay_item
      @ordering_party.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def same_params
    @item = Item.find(params[:item_id])
  end


  def seller_identification
    # @item = Item.find(params[:item_id])
    redirect_to root_path unless user_signed_in? && current_user != @item.user
  end

  def ordering_party_params
    @item = Item.find(params[:item_id])
    params.require(:ordering_party).permit(:post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, price: @item.price, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: ordering_party_params[:price], # 商品の値段
      card: ordering_party_params[:token],   # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end

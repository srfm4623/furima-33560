class OrdersController < ApplicationController
  before_action :seller_identification, only: :index


  def index
    @item = Item.find(params[:item_id])
    @ordering_party = OrderingParty.new
  end

  def create 
    @item = Item.find(params[:item_id])
    @ordering_party = OrderingParty.new(ordering_party_params)
    if @ordering_party.valid?
      @ordering_party.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def seller_identification
    @item = Item.find(params[:item_id])
    redirect_to root_path unless user_signed_in? && current_user != @item.user

  end

  def ordering_party_params
    item = Item.find(params[:item_id])
    params.require(:ordering_party).permit(:post_number, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: item.id)
  end

end

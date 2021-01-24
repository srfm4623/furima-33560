class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def new
    @item = Item.new
    @category = Category.all
    @condition = Condition.all
    @shipping_cost = Shipping_cost.all
    @prefecture = Prefecture.all
    @arrival_date = Arrival_date.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:image,:title,:text,:category_id,:condition_id,:shipping_cost_id,:prefecture_id,:arrival_id)
  end
end

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :same_params, only: [:show, :edit]
  before_action :seller_identification, only: :edit


  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :text, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :arrival_date_id, :price).merge(user_id: current_user.id)
  end

  def same_params
    @item = Item.find(params[:id])
  end

  def seller_identification
    unless current_user == @item.user
      redirect_to root_path
    end
  end

end

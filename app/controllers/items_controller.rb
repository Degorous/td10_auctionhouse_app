class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show]

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: t('.item_success')
    else
      @categories = Category.all
      flash.now[:notice] = t('.item_fail')
      render 'new'
    end
  end

  def show; end

  def index
    @items = Item.all
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :weight, :height, :width, :depth, :category_id, :image)
  end
end
class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index, :show]

  def with_tax_price
    (price * 1.1).floor
  end

  def index
    @items = Item.all
    @searchitems = Item.search(params[:search])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end
end

class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def with_tax_price
    (price * 1.1).floor
  end

  def index
    @cart_items = current_customer.cart_items
  end



  def create
    cart_item = CartItem.new(cart_item_params)
    current_cartitem = current_customer.cart_items
    if current_cartitem.find_by(item_id: params[:cart_item][:item_id])
      count = params[:cart_item][:amount].to_i
      item = current_cartitem.find_by(item_id: params[:cart_item][:item_id])
      item.increment(:amount, count)
      item.save
    else
      cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end

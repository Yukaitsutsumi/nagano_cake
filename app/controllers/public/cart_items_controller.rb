class Public::CartItemsController < ApplicationController

  def with_tax_price
    (price * 1.1).floor
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.save
    redirect_to cart_items_path
  end

  def update
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

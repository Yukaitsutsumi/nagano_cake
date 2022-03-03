class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
  end

  def update
  end

end

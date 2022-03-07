class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  #製作ステータスの更新
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end


  private
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end
end

class Public::CartItemsController < ApplicationController

  def with_tax_price
    (price * 1.1).floor
  end

  def index
    @cart_items = current_customer.cart_items
  end



  def create
    # CartItemの空の入れ物を作る
    cart_item = CartItem.new(cart_item_params)
    # CartItemモデル内からparamsに格納されているitem_idに合致するものを取得
    if CartItem.find_by(item_id: params.dig(:cart_item, :item_id))
      # ここに個数を追加する処理を記述する
      # params内のamountをcount変数に代入（同時にint型に変換）
      count = params.dig(:cart_item, :amount).to_i
       # CartItemにparams内のitem_idに合致する物を変数に代入
      item = CartItem.find_by(item_id: params.dig(:cart_item, :item_id))
      # item変数のamountにcount変数内の数字を加算
      item.increment(:amount, count)
      # 保存
      item.save
    else
      cart_item.save
    end
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

class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index, :show]

  def with_tax_price
    (price * 1.1).floor
  end

  def index
    @genres = Genre.all
    #paramsで受け取ったもの[名前]が存在していれば、、、
    if params[:genre_id]
      #＠genreに受け取ったもの[名前]のなかにある値を入れる（スイーツとか）
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.all
    else
      @items = Item.all
    end
  end

  def search
    @genres = Genre.all
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end
end

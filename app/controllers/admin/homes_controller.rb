class Admin::HomesController < ApplicationController
  def top
    @items = @admin.items
  end
end

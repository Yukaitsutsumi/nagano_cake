class Item < ApplicationRecord
  
  belongs_to :admin
  attachment :image
  
end

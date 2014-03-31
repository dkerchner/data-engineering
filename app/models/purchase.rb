class Purchase < ActiveRecord::Base
    belongs_to :item
    belongs_to :customer
    belongs_to :merchant
end

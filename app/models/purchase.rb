class Purchase < ActiveRecord::Base
    belongs_to :item
    belongs_to :customer
    belongs_to :merchant
    
    def gross_revenue 
        self.quantity * self.item.price
    end
end

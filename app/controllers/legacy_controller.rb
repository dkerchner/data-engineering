class LegacyController < ApplicationController
  require 'csv'
  def import_file
    if request.post?
      total_gross_revenue = 0.0
      CSV.foreach(params[:file].path, :headers => true, :col_sep => "\t") do |row|
        record = row.to_hash
        #Find or create customer
        customer = Customer.find_by full_name: record["purchaser name"]
        customer = Customer.new({:full_name => record["purchaser name"]}) unless customer
        #Find or create merchant
        merchant = Merchant.find_by name: record["merchant name"]
        merchant = Merchant.new({:name => record["merchant name"], :address => record["merchant address"]}) unless merchant
        #Find or create item
        item = Item.find_by name: record["item description"]
        item = Item.new({:name => record["item description"], :price => record["item price"]}) unless item
        #create the purchase record
        purchase = Purchase.new({:item => item, :merchant => merchant, :customer => customer, :quantity => record["purchase count"]})
        purchase.save!
        
        total_gross_revenue += purchase.gross_revenue
      end
      redirect_to :purchases, notice: "Total gross revenue imported: $#{total_gross_revenue.to_s}"
    else 
      render
    end
  end
end

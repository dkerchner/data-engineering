class LegacyController < ApplicationController
  require 'csv'
  def import_file
    if request.post?
      CSV.foreach(params[:file].path, :headers => true, :col_sep => "\t") do |row|
        record = row.to_hash
        customer = Customer.find_by full_name: record["purchaser name"]
        Rails.logger.info customer.inspect
        customer = Customer.new({:full_name => record["purchaser name"]}) unless customer
        Rails.logger.info customer.inspect
        merchant = Merchant.find_by name: record["merchant name"]
                Rails.logger.info merchant.inspect

        merchant = Merchant.new({:name => record["merchant name"], :address => record["merchant address"]}) unless merchant
                        Rails.logger.info merchant.inspect

        item = Item.find_by name: record["item description"]
                        Rails.logger.info item.inspect

        item = Item.new({:name => record["item description"], :price => record["item price"]}) unless item
                        Rails.logger.info item.inspect

        
        purchase = Purchase.new({:item => item, :merchant => merchant, :customer => customer, :quantity => record["item count"]})
        purchase.save!
      end
      redirect_to :purchases

    else 
      render
    end
  end
end

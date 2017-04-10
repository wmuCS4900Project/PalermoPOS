class DefaultController < ApplicationController
  def index
  	@pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @pending_count = @pending.length

    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed_count = @completed.length

    @users_count = User.count

    @customers_count = Customer.count

    # Get total money made so far
    @total_revenue = 0
    @completed.each do |order|
    	puts order
    	@total_revenue += order.TotalCost
    end

    # Preserve flash through redirects
    #flash.keep
    # we don't actually want this happen!
  end
end

class ManagementController < ApplicationController

  def index
    @users = User.all
  end
  
  def cashoutdrivers
    
    @today = Time.now.to_date
    @orders = Order.where("IsDelivery IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @users = User.with_role(:driver).all
    
    if params[:driver_id].present?
      puts "got a driver ID"
      @driver = User.find(params[:driver_id])
      @orders = Order.where("IsDelivery IS true AND PaidFor = true AND DriverID = ? AND created_at BETWEEN ? AND ?", @driver.id, DateTime.now.beginning_of_day, DateTime.now.end_of_day).all 
      
      @tiptotal = 0.0
      @orders.each do |a|
        @tiptotal += a.Tip.to_f
      end
      
      puts @tiptotal
    else
      puts "no driver id"
    end
    
  end
  
  def palconfig
    @palconfigs = Palconfig.all
  end
  
  def palconfigedit
    
    @palconfig = Palconfig.find(c)
    
  end
  
  
  
  #end of day print out page to show sales totals and breakdowns by item
  def endofday
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @refunded = Order.where("Refunded IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    
    if @pending.size > 0
      redirect_to management_path, :flash => { :notice => "You may not do End of Day while any orders are still pending!" }    
    end
    
    
    productCount = ActiveRecord::Base.connection.exec_query(query)
    @cols = productCount.columns
    @rows = productCount.rows
    
    puts @cols.inspect
    puts @rows.inspect
    
    @subtotals = Array.new(4, 0.0)
    @taxtotals = Array.new(4, 0.0)
    @tottotals = Array.new(4, 0.0)
    @cashtotal = Array.new(4, 0.0)
    @credittotal = Array.new(4, 0.0)
    
    @pending.each do |a|
      @subtotals[0] += a.Subtotal
      @taxtotals[0] += a.Tax
      @tottotals[0] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[0] += a.TotalCost
      else
        @credittotal[0] += a.TotalCost
      end
    end
    
    @completed.each do |a|
      @subtotals[1] += a.Subtotal
      @taxtotals[1] += a.Tax
      @tottotals[1] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[1] += a.TotalCost
      else
        @credittotal[1] += a.TotalCost
      end
    end
    
    @cancelled.each do |a|
      @subtotals[2] += a.Subtotal
      @taxtotals[2] += a.Tax
      @tottotals[2] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[2] += a.TotalCost
      else
        @credittotal[2] += a.TotalCost
      end
    end

    @completed.each do |a|
      @subtotals[3] += a.Subtotal
      @taxtotals[3] += a.Tax
      @tottotals[3] += a.TotalCost
      if a.PaidCash == true
        @cashtotal[3] += a.TotalCost
      else
        @credittotal[3] += a.TotalCost
      end
    end
    

    
  end
  
  #query to get a count of each product sold during the day
  def query
    <<-SQL
    SELECT product_id, COUNT(*), SUM(ItemTotalCost)
    FROM orderlines
    LEFT JOIN orders
    ON orderlines.order_id = orders.id
    WHERE Paidfor = 1
    GROUP BY product_id;
    SQL
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:Name,:Cost,:category_id,:Abbreviation,:ChildOf)
    end
end

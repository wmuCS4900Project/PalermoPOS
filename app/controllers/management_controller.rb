class ManagementController < ApplicationController


  def index
    @users = User.all
  end
  
  def cashoutdrivers
    if ( !logged_in? || !current_user.can?("view", "management"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
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
    if ( !logged_in? || !current_user.can?("view", "configurations"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    @palconfigs = Palconfig.all
  end
  
  def palconfigedit
    if ( !logged_in? || !current_user.can?("edit", "configurations"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    @palconfig = Palconfig.find(c)
    
  end
  
  def salesreport
    if ( !logged_in? || !current_user.can?("view", "management"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
  end
  
  def genreport
    if ( !logged_in? || !current_user.can?("view", "management"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    @reporttype = params[:reporttype]
    
    if @reporttype == 'overall sales'
      @year = params[:startdate]['(1i)'].to_s
      @month = params[:startdate]['(2i)'].to_s
      @day = params[:startdate]['(3i)'].to_s
      @date1 = @year + '-' + @month + '-' + @day
      @year = params[:enddate]['(1i)'].to_s
      @month = params[:enddate]['(2i)'].to_s
      @day = params[:enddate]['(3i)'].to_s
      @date2 = @year + '-' + @month + '-' + @day
      @customers = Customer.all
      @completed = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all
      @cancelled = Order.where("PaidFor IS false AND Cancelled IS true AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all
      @refunded = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS true AND DATE(created_at) >= ? AND DATE(created_at) <= ?", @date1, @date2).all
      
      @orders.where(status: :paid).sum(:cost)
      @totalcharges = @completed.sum(:TotalCost) + @refunded.sum(:TotalCost)
      @totaltax = @completed.sum(:Tax) + @refunded.sum(:Tax)
      @totaltip = @completed.sum(:Tip) + @refunded.sum(:Tip)
      @totaldelivery = @completed.sum(:DeliveryCharge) + @refunded.sum(:DeliveryCharge)
      @totalrevenue = @totalcharges - @totaltax - @totaldelivery - @totaltip
      
      @cancelledcharges = @cancelled.sum(:TotalCost)
      @cancelledtax = @cancelled.sum(:Tax)
      @cancelledtip = @cancelled.sum(:Tip)
      @cancelleddelivery = @cancelled.sum(:DeliveryCharge)
      @cancelledrevenue = @cancelledcharges - @cancelledtax - @cancelledtip - @cancelleddelivery
      
      @pickupscompleted = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ? AND IsDelivery = false", @date1, @date2).all
      @pickupcount = @pickupscompleted.count
      @deliveriescompleted = Order.where("PaidFor IS true AND Cancelled IS false AND Refunded IS false AND DATE(created_at) >= ? AND DATE(created_at) <= ? AND IsDelivery = true", @date1, @date2).all
      @deliverycount = @deliveriescompleted.count
      @pickuprev = @pickupscompleted.sum(:TotalCost) - @pickupscompleted.sum(:Tax) - @pickupscompleted.sum(:Tip) - @pickupscompleted.sum(:DeliveryCharge)
      @deliveryrev = @deliveriescompleted.sum(:TotalCost) - @deliveriescompleted.sum(:Tax) - @deliveriescompleted.sum(:Tip) - @deliveriescompleted.sum(:DeliveryCharge)
      
      return
    end
  end
  
  #end of day print out page to show sales totals and breakdowns by item
  def endofday
    if ( !logged_in? || !current_user.can?("view", "management"))
      redirect_to root_path, :flash => { :notice => "You do not have permission to do this!" }
      return
    end
    
    @customers = Customer.all
    @pending = Order.where("PaidFor IS false AND Cancelled IS false AND Refunded IS false AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @cancelled = Order.where("Cancelled IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @completed = Order.where("PaidFor IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @refunded = Order.where("Refunded IS true AND created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    
    if @pending.size > 0
      redirect_to management_path, :flash => { :danger => "You may not do End of Day while any orders are still pending!" }    
      return
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

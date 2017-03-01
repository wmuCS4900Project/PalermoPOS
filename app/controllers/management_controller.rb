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

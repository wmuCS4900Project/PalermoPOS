class OrderlinesController < ApplicationController
  
  def destroy
    if ( !logged_in? || !current_user.can?("destroy", "orderlines"))
      redirect_to root_path, :flash => { :danger => "You do not have permission to do this!" }
      return
    end
    
    puts params.inspect
    @orderline = Orderline.find(params[:id])
    @order_id = @orderline.order_id
    puts @order_id
    @orderline.destroy
    redirect_to orders_recalcForOrderlineDelete_path(:order_id => @order_id)
  end
  
end

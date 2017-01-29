class OrderlinesController < ApplicationController
  
  def destroy
    puts params.inspect
    @orderline = Orderline.find(params[:id])
    @order_id = @orderline.order_id
    puts @order_id
    @orderline.destroy
    redirect_to orders_selectproduct_path(:order_id => @order_id), :flash => { :notice => 'Order line deleted.' }
  end
  
end

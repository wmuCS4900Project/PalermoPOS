####### in routes.rb
  post "/orders/new"


####### in controller
  def new
    @order = Order.new
    @products = Product.all
    @got = params[:item1] #printed on the new page after submission
    puts "did the thing"
  end
  
####### in _form file
<%= form_tag(orders_new_path, :method=>'post', :multipart => true) do %>

  <select name="item1"> #this name determines the params var name params[:item1]
    <% @products.each do |p| %>
      <tr>
        <option value="<%= p.id %>"><%= p.Name =%></option> #pulls p.id from products, displays name for user
      </tr>
    <% end %>
  </select>
  
  <br><br>
  <div class="actions">
    <%= submit_tag "Start New Order" %> #submit_tag is the submit here, routes to create in controller above
  </div>
  
  <div>
    <%= @got %>
    <%= params.inspect %> #debug info
  </div>
<% end %>
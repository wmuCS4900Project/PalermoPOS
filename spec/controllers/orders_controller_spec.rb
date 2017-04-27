require "rails_helper"

RSpec.describe OrdersController, :type => :controller do
  

  describe 'GET #custsearch' do
    
    before(:each) do
      
      FactoryGirl.create :role, :admin
      FactoryGirl.create :cap, :all
      @u1 = FactoryGirl.create :user, :admin, id: "1", username: "admin", password: "admin123", Name: "admin"
      log_in(@u1)
      @c1 = FactoryGirl.create :customer, :one 
      @c2 = FactoryGirl.create :customer, :two
      @c3 = FactoryGirl.create :customer, :three
    end

    it "finds custsearch" do
      get :custsearch
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
    
    it "finds customer 1 and 3 by phone" do
      get :custsearch, params: { searchcriteria: 'phone', criteria: '111' }
      expect(assigns(:results)).to include(@c1)
      expect(assigns(:results)).not_to include(@c2)
      expect(assigns(:results)).to include(@c3)
    end
    
    it "finds user 2 by firstname" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'bob' }
      expect(assigns(:results)).not_to include(@c1)
      expect(assigns(:results)).to include(@c2)
      expect(assigns(:results)).not_to include(@c3)
    end
  
    it "finds user 1 by lastname" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'smith' }
      expect(assigns(:results)).to include(@c1)
      expect(assigns(:results)).not_to include(@c2)
      expect(assigns(:results)).not_to include(@c3)
    end
    
    it "finds no users by name" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'randy' }
      expect(assigns(:results)).not_to include(@c1)
      expect(assigns(:results)).not_to include(@c2)
      expect(assigns(:results)).not_to include(@c3)
    end    
  end
  
  
  
  describe 'GET #startorder' do
    
    before(:each) do
      @u1 = FactoryGirl.build :user, id: "1", username: "admin", password: "admin123", IsManager: true, Driver: false
      log_in(@u1)
      @c1 = FactoryGirl.create :customer, :one 
      @c2 = FactoryGirl.create :customer, :two
      @c3 = FactoryGirl.create :customer, :three
      
      @o1 = FactoryGirl.create :order, :pending, :new, user: @u1, customer: @c1
    end
    
    # it "gets redirected to startorder if custid sent" do
    #   get :startorder, params: { custid: @c1.id, mode: "pickup" }
    #   expect(response).to redirect_to('/orders/selectproduct')
    # end
    
    it "gets redirected to orders if custid not sent" do
      get :startorder
      expect(response).to redirect_to '/orders'
    end
    
    # it "should create a new order with customer 1" do
    #   expect{ get :startorder, params: { custid: @c1.id }}.to change{ Order.all.count }.by(1)
    #   expect{ get :startorder, params: { custid: @c1.id }}.to change{ Order.all.count }.by(1)
    #   expect{ get :startorder, params: { custid: @c1.id }}.to change{ Order.all.count }.by(1)
    #   expect(Order.last.customer_id == @c1.id)
    #   expect(Order.last.user_id == 1)
    # end
    
    it "should create a new order with customer default" do
      get :startorder
      expect(Order.last.customer_id == 1)
    end
  end
  
  
  # describe 'GET #selectproduct' do
    
  #   before(:each) do
  #     @u1 = FactoryGirl.build :user, id: "1", username: "admin", password: "admin123", IsManager: true, Driver: false
  #     log_in(@u1)
  #     @c1 = FactoryGirl.create :customer, :one 
  #     @c2 = FactoryGirl.create :customer, :two
  #     @c3 = FactoryGirl.create :customer, :three
      
  #     @o1 = FactoryGirl.create :order, :pending, :new, user: @u1, customer: @c1
  #   end
    
  #   it "gets selectproduct path" do
  #     get :selectproduct, params: { order_id: @o1.id }
  #     expect(response).to be_success
  #   end
    
  #   it "gets redirected to orders if custid not sent" do
  #     get :selectproduct
  #     expect(response).to redirect_to '/orders'
  #   end
    
  #   it "has the right order" do
  #     get :selectproduct, params: { order_id: @o1.id }
  #     expect(assigns(:order).id).to be(@o1.id)
  #   end

    
  # end
  
  # describe 'GET #addproducttoorder' do
    
  #   before(:each) do
  #     @u1 = FactoryGirl.build :user, id: "1", username: "admin", password: "admin123", IsManager: true, Driver: false
  #     log_in(@u1)
  #     @c1 = FactoryGirl.create :customer, :one 
  #     @c2 = FactoryGirl.create :customer, :two
  #     @c3 = FactoryGirl.create :customer, :three
  #     @cat1 = FactoryGirl.create :category, :pizza
  #     @prod2 = FactoryGirl.create :product, :two
      
  #     @o1 = FactoryGirl.create :order, :pending, :new, user: @u1, customer: @c1
  #   end
    
  #   it "gets addproducttoorder path failure missing all params" do
  #     get :addproducttoorder, params: { }
  #     expect(response).to redirect_to '/orders'
  #     expect(flash[:notice]).to match(/No current order!/)
  #   end
    
  #   it "gets addproducttoorder path failure missing order id" do
  #     get :addproducttoorder, params: { product_id: @prod2.id }
  #     expect(response).to redirect_to '/orders'
  #     expect(flash[:notice]).to match(/No current order!/)
  #   end
    
  #   it "gets addproducttoorder path failure missing product id" do
  #     get :addproducttoorder, params: { order_id: @o1.id }
  #     expect(response).to redirect_to '/orders'
  #     expect(flash[:notice]).to match(/No product selected!/)
  #   end
    
  #   it "assigns correct order" do
  #     get :addproducttoorder, params: { order_id: @o1.id, product_id: @prod2.id }
  #     expect(assigns(:order).id).to be(@o1.id)
  #   end
    
  #   #it "correctly calculates subtotal" do   
  #     #get :addproducttoorder, params: { order_id: @o1.id, product_id: @prod2.id }
  #     #expect(assigns(:subtotal)).to be(@prod2.Cost)
  #     #expect(assigns(:order).SubTotal).to be(@prod2.Cost)
  #   #end
  # end
  
end
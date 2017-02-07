require "rails_helper"

RSpec.describe OrdersController, :type => :controller do
  
  let(:o1) { create :order, :one, :new, :pending }
  let(:o2) { create :order, :one, :new, :completed }
  let(:o3) { create :order, :one, :new, :refunded }
  let(:o4) { create :order, :one, :new, :cancelled }
  let(:o5) { create :order, :one, :old, :pending }
  let(:o6) { create :order, :one, :old, :completed }
  let(:o7) { create :order, :one, :old, :refunded }
  let(:o8) { create :order, :one, :old, :cancelled }
  
  
  describe 'GET #index' do

  end

  describe 'GET #custsearch' do
    
    let!(:first) { create :customer, :one }
    let!(:second) { create :customer, :two }
    let!(:third) { create :customer, :three }
    
    it "finds custsearch" do
      get :custsearch
      expect(response).to be_success
    end
    
    it "finds user 1 and 3 by phone" do
      get :custsearch, params: { searchcriteria: 'phone', criteria: '111' }
      assigns(:results).should include(first)
      assigns(:results).should_not include(second)
      assigns(:results).should include(third)
    end
    
    it "finds user 2 by firstname" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'bob' }
      assigns(:results).should_not include(first)
      assigns(:results).should include(second)
      assigns(:results).should_not include(third)
    end
  
    it "finds user 1 by lastname" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'smith' }
      assigns(:results).should include(first)
      assigns(:results).should_not include(second)
      assigns(:results).should_not include(third)
    end
    
    it "finds no users by name" do
      get :custsearch, params: { searchcriteria: 'name', criteria: 'randy' }
      assigns(:results).should_not include(first)
      assigns(:results).should_not include(second)
      assigns(:results).should_not include(third)
    end
    
    
  end
  
  describe 'GET #startorder' do
    
    let!(:first) { create :customer, :one }

    it "finds startorder" do
      get :startorder
      expect(response).to be_success
    end
    
    it "should create a new order with customer 1" do
      expect(get :startorder, params: { custid: first.id }).to change(Order, :count).by(1)
      expect(Order.last.customer_id == first.id)
    end
    
    it "should create a new order with customer default" do
      get :startorder
      expect(Order.last.customer_id == 1)
    end
  end
  
end
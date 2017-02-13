require "rails_helper"

RSpec.describe OrdersController, :type => :controller do
  

  describe 'GET #custsearch' do
    
    before(:each) do
      @u1 = FactoryGirl.build :user, id: "1", username: "admin", password: "admin123", IsManager: true, Driver: false
      login(@u1)
      @c1 = FactoryGirl.create :customer, :one 
      @c2 = FactoryGirl.create :customer, :two
      @c3 = FactoryGirl.create :customer, :three

    end

    it "finds custsearch" do
      get :custsearch
      expect(response).to be_success
    end
    
    it "finds customer 1 phone" do
      get :custsearch, params: { searchcriteria: 'phone', criteria: '111' }
      expect(assigns(:results)).to include(@c1)
      expect(assigns(:results)).not_to include(@c2)
      expect(assigns(:results)).to include(@c3)
    end
  end
  
end
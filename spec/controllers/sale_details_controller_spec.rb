require 'rails_helper'


RSpec.describe SaleDetailsController ,type: :controller do
    context "test" do
    it "displays all yearly and monthily data" do
      get :index
      expect(response.status).to eq 200
    end
  end
end
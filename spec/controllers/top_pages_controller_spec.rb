require 'rails_helper'

RSpec.describe TopPagesController, type: :controller do
  describe "GET #home" do
    it "responds successful" do
      get :home
      expect(response).to be_success
    end
  end
end

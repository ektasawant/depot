require 'rails_helper'

describe User do

    it "has a valid factory" do
        expect(create(:user)).to be_valid
    end

    it "is invalid without a name" do
        expect(build(:user, name: nil)).to be_invalid
    end
    it "has a unique name" do
        create(:user,name:"swati")
        expect(build(:user,name:"swati")).to be_invalid
    end
    describe "#ensure_an_admin_remains" do
    it "should not delete last user" do
      #cart = create :cart
      user = create :user
      expect(user).to receive(:ensure_an_admin_remains)
      user.run_callbacks(:destroy)
    end
  end
end

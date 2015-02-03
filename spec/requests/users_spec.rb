require 'rails_helper'
describe 'user management' do
  it "adds a new user" do
    user = create(:user)
    visit login_path
    fill_in 'Name' , with: user.name
    fill_in 'Password' , with: user.password
    click_button 'Login'
    visit store_path
    expect{
      click_link 'Users'
      click_link 'New User'
      fill_in 'Name',with: 'Ekta'
      fill_in 'Password' , with: 'ekta'
      fill_in 'Confirm' , with: 'ekta'
      click_button 'Create User'
    }.to change(User,:count).by(1)
    expect(current_path).to eq users_path
    expect(page).to have_content "User Ekta was successfully created"
    within 'h1' do
      expect(page).to have_content 'Listing Users'
    end
    expect(page).to have_content 'Ekta'
  end

end

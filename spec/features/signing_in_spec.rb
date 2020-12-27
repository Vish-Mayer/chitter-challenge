# frozen_string_literal: true

feature 'user sign in' do

  before do
  User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
  end
  scenario 'user can sign in with the correct account details' do
    visit('/')
    fill_in 'email', with: 'test@testmail.com'
    fill_in 'password', with: 'Password123'
    click_button('submit')
    expect(current_path).to eq '/peeps'
    expect(page).to have_content('test_username')
  end
end

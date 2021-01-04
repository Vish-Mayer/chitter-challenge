# frozen_string_literal: true

feature 'user sign out' do

  before do
    User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
  end

  scenario 'user can end the session by clicking "Sign out"'do

    sign_in

    expect(current_path).to eq '/peeps'
    expect(page).to have_content('test_username')

    click_button('sign_out')
    expect(page).not_to have_content('test_username')
    expect(page).to have_content('Signed out.')
  end
end

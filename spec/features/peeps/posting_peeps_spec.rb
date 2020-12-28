# frozen_string_literal: true

feature 'creating peeps' do

  before do
  User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
  end

  scenario 'user can post a peep when signed in' do
    sign_in
    expect(current_path).to eq '/peeps'

    fill_in 'text_area', with: 'this is a test peep'
    click_button('Peep')

    expect(page).to have_content('this is a test peep')
    expect(page).to have_content('today')
  end
end

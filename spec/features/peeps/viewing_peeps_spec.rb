# frozen_string_literal: true

feature 'viewing peeps' do

  before do
  User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
  end

  scenario 'user can see the most recent peeps that have been posted' do
    sign_in
    expect(current_path).to eq '/peeps'

    fill_in 'text_area', with: 'this is a test peep'
    click_button('submit')

    expect(page).to have_content('this is a test peep')
  end

  scenario 'user can see when a peep was posted' do
    sign_in
    expect(current_path).to eq '/peeps'

    fill_in 'text_area', with: 'this is a test peep'
    click_button('submit')

    expect(page).to have_content('this is a test peep')
    # expect(page).to have_content('today')
  end
end

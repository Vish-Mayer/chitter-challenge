# frozen_string_literal: true

feature 'user sign up' do
  scenario 'user visits homepage and signs up to view peeps' do

    visit('/')
    click_button('sign_up')

    expect(current_path).to eq '/users/new'

    fill_in 'username', with: 'test_username'
    fill_in 'email', with: 'test@testmail.com'
    fill_in 'password', with: 'Password123'
    click_button('submit')

    expect(current_path).to eq '/peeps'
    expect(page).to have_content('test_username')
  end

    scenario 'user cannot use an exisiting username or email to sign up' do

    User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')

    visit('/')
    click_button('sign_up')

    expect(current_path).to eq '/users/new'

    fill_in 'username', with: 'test_username'
    fill_in 'email', with: 'test@testmail.com'
    fill_in 'password', with: 'Password123'
    click_button('submit')

    expect(current_path).to eq '/users/new'
    expect(page).to have_content('Username or Email is already being used')
  end
end

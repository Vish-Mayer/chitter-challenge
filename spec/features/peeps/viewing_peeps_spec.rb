# frozen_string_literal: true

# feature 'viewing peeps' do
#   scenario 'user can see the most recent peeps' do
#     visit('/')
#     click_button('sign_up')
#     expect(current_path).to eq '/users/new'
#     fill_in 'username', with: 'test_username'
#     fill_in 'email', with: 'test@testmail.com'
#     fill_in 'password', with: 'Password123'
#     click_button('submit')
#     expect(current_path).to eq '/peeps'
#     expect(page).to have_content('test_username')
#   end
# end

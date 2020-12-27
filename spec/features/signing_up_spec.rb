# # frozen_string_literal: true
#
# feature 'user sign up' do
#   scenario 'user visits homepage and signs up to view peeps' do
#     visit('/')
#     click_button('sign_up')
#     visit('/users/new')
#     fill_in 'username', with: 'test_username'
#     fill_in 'email', with: 'test@testmail.com'
#     fill_in 'password', with: 'Password123'
#     click_button('submit')
#     expect(page).to have_content('test_username')
#   end
# end

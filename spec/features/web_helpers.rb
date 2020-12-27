def sign_in
  visit('/')
  fill_in 'email', with: 'test@testmail.com'
  fill_in 'password', with: 'password123'
  click_button('submit')
end

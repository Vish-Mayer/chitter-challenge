feature 'Sign in page' do
  scenario 'it greets the user and has a log in button ' do 
  visit('/sign_in')
  expect(page).to have_content('Welcome to Chitter!')
  expect(page).to have_button('Log in')
  end
end


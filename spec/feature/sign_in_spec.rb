feature 'Sign in page' do
  scenario 'it greets the user and asks for login details ' do 
  visit('/sign_in')
  expect(page).to have_content('Welcome to Chitter!')
  expect(page).to have_button('Log in')
  end
end


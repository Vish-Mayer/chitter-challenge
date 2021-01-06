# frozen_string_literal: true
feature 'comments' do
  scenario 'making and displaying comments' do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    @peep = Peep.create(body: 'this is a test peep')

    visit('/')
    fill_in 'email', with: 'test@testmail.com'
    fill_in 'password', with: 'password123'
    click_button('Sign In')
    expect(current_path).to eq("/peeps")

    fill_in 'comment', with: 'testing comments'
    click_button('Comment')

    expect(current_path).to eq("/peeps")

    expect(first('.peep')).to have_content "testing comments"
    expect(first('.peep')).to have_content "testing comments"
  end
end

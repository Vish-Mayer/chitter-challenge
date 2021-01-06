# frozen_string_literal: true
feature 'comments' do

  before :each do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    @peep = Peep.create(body: 'this is a test peep')
  end

  scenario 'making and displaying comments' do

    visit('/')
    sign_in
    expect(current_path).to eq("/peeps")

    fill_in 'comment', with: 'testing comments'
    click_button('Comment')

    expect(current_path).to eq("/peeps")

    expect(first('.peep')).to have_content "testing comments"
    expect(first('.peep')).to have_content "testing comments"
  end

  scenario 'user cannot make a comment if they are not signed in' do
    visit('/peeps')
    expect(first('.peep')).not_to have_button("Comment")
  end
end

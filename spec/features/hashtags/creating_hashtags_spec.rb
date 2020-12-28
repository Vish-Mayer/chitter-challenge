# frozen_string_literal: true

feature 'creating hashtags' do

  before do
    User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    sign_in
  end

  scenario 'user can create a tag in a peep by putting a "#" at the start of a word' do

    expect(current_path).to eq '/peeps'

    fill_in 'text_area', with: 'this is a test #hashtag'
    click_button('Peep')
    expect(first('.peep')).to have_content('this is a test #hashtag')
    expect(first('.peep')).to have_selector(:link_or_button, '#hashtag')
  end
end

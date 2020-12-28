# frozen_string_literal: true
require 'data_matcher'

feature 'creating hashtags' do

  before do
    User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    sign_in
    fill_in 'text_area', with: 'this is a test #hashtag'
    click_button('Peep')
  end

  scenario 'user can filter through peeps by the given hashtags' do

    expect(first('.peep')).to have_selector(:link_or_button, '#hashtag')
    first('.peep').click_button('#hashtag')

    hashtag_id = data_matcher('id', 'hashtags')
    content = data_matcher('content', 'hashtags')
    expect(current_path).to eq("/peeps/hashtags/#{hashtag_id[0]}")

    expect(page).to have_content('this is a test #hashtag')
  end
end

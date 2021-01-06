# frozen_string_literal: true
feature 'making comments comments' do
  scenario 'displays comments made on a bookmark' do
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

    # first('.peep').click_link('show comments')

    expect(first('.peep')).to have_content "testing comments"

    # first('.bookmark').click_button('add_comment')
    #
    # expect(current_path).to eq("/bookmarks/#{bookmark.id}/comments/new")
    #
    # fill_in 'comment', with: 'testing viewing comments'
    # click_button('submit')
    #
    # expect(current_path).to eq('/bookmarks')
    # expect(first('.bookmark')).to have_content 'testing viewing comments'
  end
end

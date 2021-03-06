feature 'viewing own peeps' do

  before do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    @peep = Peep.create(body: 'this is a test peep')
    UserPeep.create(user_id: @user.id, peep_id: @peep.id)
    @peep2 = Peep.create(body: 'this is another test peep')
  end

  scenario 'user can log in and click on their username to see peeps that they have made' do
    sign_in
    visit('/peeps')
    expect(page).to have_content 'this is a test peep'
    expect(page).to have_content 'this is another test peep'
    expect(page).to have_selector(:link_or_button, 'test_username')
    click_link('test_username')

    expect(current_path).to eq('/user_page')
    expect(page).to have_content 'this is a test peep'
    expect(page).not_to have_content 'this is another test peep'
  end

  scenario 'user can see peeps that they have been tagged in' do

    user2 = User.create(username: 'tagger', email: 'tagger@testmail.com', password: 'password123')
    UserPeep.create(user_id: user2.id, peep_id: @peep2.id)
    UserActivity.create(type: 'tagged', peep_id: @peep.id, user_1_id: user2.id, user_2_id: @user.id)
    sign_in
    visit('/peeps')
    click_link('test_username')

    expect(current_path).to eq('/user_page')
    expect(page).to have_content "tagger tagged you in a peep"
    expect(page).to have_content 'this is a test peep'
    expect(page).not_to have_content 'this is another test peep'
  end
end

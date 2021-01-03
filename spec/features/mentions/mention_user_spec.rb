feature 'mention user' do

  before do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    @user2 = User.create(username: 'test_username2', email: 'test@testmail2.com', password: 'password123')
    @user3 = User.create(username: 'test_username3', email: 'test@testmail3.com', password: 'password123')
  end

  scenario 'user can mention another user in a peep' do
    sign_in

    expect(current_path).to eq '/peeps'
    expect(page).to have_content('Signed in as, test_username')

    fill_in 'text_area', with: 'I am mentioning @test_username2 and @test_username3 in a peep'
    click_button('Peep')

    click_button('sign_out')

    expect(current_path).to eq '/'

    fill_in 'email', with: 'test@testmail2.com'
    fill_in 'password', with: 'password123'
    click_button('Sign In')

    expect(current_path).to eq '/peeps'

    expect(page).to have_content('Signed in as, test_username2')
    click_link('test_username2')

  end
end

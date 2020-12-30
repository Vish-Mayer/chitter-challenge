feature 'user tags' do

  before do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    @peep = Peep.create(body: 'this is a test peep')
  end

  scenario 'user can tag another user in a peep' do
    sign_in
    visit('/peeps')
    expect(first('.peep')).to have_content 'this is a test peep'
    find(".custom_select option[value='#{@user.id}']").select_option
    click_button 'tag_user'

    expect(current_path).to eq('/peeps')
  end

  scenario 'user can not tag another user unless they are signed in' do
    visit('/peeps')
    expect(first('.peep')).to have_content 'this is a test peep'
    expect(page).not_to have_selector(:link_or_button, 'tag_user')
  end
end

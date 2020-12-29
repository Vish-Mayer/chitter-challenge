feature 'user tags' do

  before do
    @user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    Peep.create(body: 'this is a test peep')
    sign_in
  end

  scenario 'user can tag another user in a peep' do
    visit('/peeps')
    expect(first('.peep')).to have_content 'this is a test peep'
    find(".custom-select option[value='#{@user.id}']").select_option
    click_button 'tag_user'
  end

  # scenario 'user can not post a peep unless signed in' do
  #   visit('/peeps')
  #   expect(first('.peep')).to have_content 'this is a test peep'
  #   expect(page).not_to have_selector(:link_or_button, 'Peep')
  # end

  # scenario 'user can see when a peep was posted and the author' do
  #   sign_in
  #   expect(current_path).to eq '/peeps'
  #
  #   fill_in 'text_area', with: 'this is a test peep'
  #   click_button('submit')
  #
  #   expect(first('.peep')).to have_content 'this is a test peep'
  #   expect(first('.peep')).to have_content 'today'
  #   expect(first('.peep')).to have_content 'test_username'
  # end
end

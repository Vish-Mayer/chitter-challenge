feature 'viewing peeps' do

  before do
    User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    Peep.create(body: 'this is a test peep')
  end

  scenario 'user can see the most recent peeps that have been posted' do
    visit('/peeps')
    expect(first('.peep')).to have_content 'this is a test peep'
  end

  scenario 'user can not post a peep unless signed in' do
    visit('/peeps')
    expect(first('.peep')).to have_content 'this is a test peep'
    expect(page).not_to have_selector(:link_or_button, 'Peep')
  end

  scenario 'user can see when a peep was posted and the author' do
    sign_in
    expect(current_path).to eq '/peeps'

    fill_in 'text_area', with: 'this is a test peep'
    click_button('Peep')

    expect(first('.peep')).to have_content 'this is a test peep'
    expect(first('.peep')).to have_content 'today'
    expect(first('.peep')).to have_content 'test_username'
  end
end

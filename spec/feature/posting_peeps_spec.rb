
feature 'Posts a new peep' do
  scenario 'A user can add a peep and see it on their controller' do
    visit('/homepage')
    fill_in('message', with: 'Hello Chitter')
    click_button('Peep')

    expect(page).to have_content 'Hello Chitter'
  end
end
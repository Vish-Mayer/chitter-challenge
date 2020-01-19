feature 'user homepage' do
  scenario 'it displays the users homepage' do
    visit('/homepage')
    expect(page).to have_button("Peep")
    expect(page).to have_content "A bunch of Peeps"
  end
end
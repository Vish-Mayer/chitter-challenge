require 'pg'

feature 'user homepage' do
  scenario 'it displays the users homepage' do
    connection = PG.connect(dbname: 'peep_manager_test')

    connection.exec("INSERT INTO peeps VALUES(100,'A bunch of Peeps');")
    connection.exec("INSERT INTO peeps VALUES(120,'Test Tweet');")

    visit('/homepage')

    expect(page).to have_button("Peep")
    expect(page).to have_content("Test Tweet")
    expect(page).to have_content("A bunch of Peeps")
  end
end
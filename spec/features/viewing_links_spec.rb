feature 'View links' do
  scenario 'view heading' do
    visit('/')
    expect(page).to have_content("List of bookmarks")
  end

  scenario 'view google link' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://makersacademy.com', 'Makers Academy');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://destroyallsoftware.com', 'Destroy');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://google.com', 'Google');")
    visit('/')
    expect(page).to have_content("Makers Academy")
    expect(page).to have_content("Google")
    expect(page).to have_content("Destroy")
  end

end

feature 'Adding a bookmark' do
  scenario 'adds a bookmark' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    click_button 'Add Bookmark'
    expect(page).to have_content('http://www.amazon.co.uk')
  end

  scenario 'flashes a message when url not correct' do
    visit '/'
    fill_in 'url', with: 'http:|/google.com'
    click_button 'Add Bookmark'
    expect(page).to have_content "Not a valid url"
    expect(page).not_to have_content('http:|/google.com')
  end
end

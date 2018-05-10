feature 'Adding a bookmark' do
  scenario 'adds a bookmark' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    fill_in 'title', with: 'Amazon'
    click_button 'Add Bookmark'
    expect(page).to have_content('Amazon')
    expect(page).to have_link(href: 'http://www.amazon.co.uk')
  end

  scenario 'flashes a message when url not correct' do
    visit '/'
    fill_in 'url', with: 'http:|/google.com'
    fill_in 'title', with: 'Google'
    click_button 'Add Bookmark'
    expect(page).to have_content "Not a valid url"
    expect(page).not_to have_content('Google')
  end
end

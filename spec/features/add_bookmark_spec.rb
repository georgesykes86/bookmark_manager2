feature 'Adding a bookmark' do
  scenario 'adds a bookmark' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    click_button 'Add Bookmark'
    expect(page).to have_content('http://www.amazon.co.uk')
  end
end

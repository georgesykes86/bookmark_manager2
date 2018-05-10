feature 'deletes bookmark' do
  scenario 'deletes bookmark from list' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    fill_in 'title', with: 'Amazon'
    click_button 'Add Bookmark'
    click_button 'Delete'
    expect(page).not_to have_content('Amazon')
  end
end

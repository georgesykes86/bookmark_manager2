feature 'update bookmark' do
  scenario 'updates bookmark URL' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    fill_in 'title', with: 'Amazon'
    click_button 'Add Bookmark'
    fill_in 'update_title', with: 'Amazon'
    click_button 'Update'
    fill_in 'url', with: 'http://www.amazon.com'
    fill_in 'title', with: 'Amazing Amazon'
    click_button 'Submit'
    expect(page).to have_link(href: 'http://www.amazon.com')
    expect(page).to have_content('Amazing Amazon')
  end


end

feature 'add a comment' do
  scenario 'creates comment on the bookmark' do
    visit('/')
    fill_in 'url', with: 'http://www.amazon.co.uk'
    fill_in 'title', with: 'Amazon'
    click_button 'Add Bookmark'
    click_button 'Add comment'
    fill_in 'comment', with: 'my favourite shopping site'
    click_button 'Sumbit'
    expect(page).to have_content 'my favourite shopping site'
  end
end

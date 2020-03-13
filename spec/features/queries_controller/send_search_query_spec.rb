describe 'Send search query' do
  context 'with string parameter' do
    it 'redirects succesfully', :vcr do
      visit queries_path
      within('#new_query') do
        fill_in 'query_searched_quote', with: 'Rails'
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
    end
  end

  context 'with blank parameter' do
    it 'raises exception', :vcr do
      visit queries_path
      within('#new_query') do
        fill_in 'query_searched_quote', with: ''
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
    end
  end
end

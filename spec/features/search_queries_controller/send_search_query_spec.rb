describe 'Send search query' do
  context 'with string parameter' do
    it 'redirects succesfully', :vcr do
      visit search_queries_path
      within('#new_search_query') do
        fill_in 'search_query_searched_quote', with: 'Rails'
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
    end
  end

  context 'with blank parameter' do
    it 'raises exception', :vcr do
      visit search_queries_path
      within('#new_search_query') do
        fill_in 'search_query_searched_quote', with: ''
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
    end
  end
end

describe 'Send search query', :vcr do
  context 'with string parameter' do
    it 'redirects succesfully and displays search_query object' do
      visit search_queries_path
      within('#new_search_query') do
        fill_in 'search_query_searched_quote', with: 'Rails'
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
      expect(page).to have_content('Rails')
    end
  end

  context 'with blank parameter' do
    it 'redirects succesfully' do
      visit search_queries_path
      within('#new_search_query') do
        fill_in 'search_query_searched_quote', with: ''
      end
      click_button 'Search'
      expect(page).to have_content('Query created!')
    end
  end
end

describe 'Update search query', :vcr do
  it 'redirects succesfully and display search query list' do
    search_query = create(:search_query)
    visit edit_search_query_path(search_query)
    within('.edit_search_query') do
      fill_in 'search_query_searched_quote', with: 'Rails'
    end
    click_button 'Update'
    expect(page.current_path).to eq(search_queries_path)
    expect(page).to have_content('Query updated!')
    expect(page).to have_content('Rails')
  end
end

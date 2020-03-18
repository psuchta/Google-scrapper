describe 'delete query' do
  it 'redirects succesfully', :vcr do
    create(:search_query)
    visit search_queries_path
    click_link 'Delete'
    expect(page).to have_content('Query destroyed!')
    expect(page.current_path).to eq(search_queries_path)
  end
end

describe 'Visit index page' do
  it 'displays list of queries' do
    queries = create_list(:search_query, 3)
    visit search_queries_path
    queries.each do |search_query|
      expect(page).to have_content(search_query.searched_quote)
    end
  end

  it 'displays destroy edit details buttons' do
    create(:search_query)
    visit search_queries_path
    expect(page).to have_content('Delete')
    expect(page).to have_content('Edit')
    expect(page).to have_content('Details')
  end

  it 'displays google search button' do
    visit search_queries_path
    expect(page).to have_content('Search')
  end
end

describe 'Visit index page' do
  it 'displays list of queries' do
    queries = create_list(:query, 3)
    visit queries_path
    queries.each do |query|
      expect(page).to have_content(query.searched_quote)
    end
  end

  it 'displays destroy edit details buttons' do
    create(:query)
    visit queries_path
    expect(page).to have_content('Delete')
    expect(page).to have_content('Edit')
    expect(page).to have_content('Details')
  end

  it 'displays google search button' do
    visit queries_path
    expect(page).to have_content('Search')
  end
end

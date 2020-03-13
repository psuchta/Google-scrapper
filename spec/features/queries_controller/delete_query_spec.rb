describe 'delete query' do
  it 'redirects succesfully', :vcr do
    query = create(:query)
    visit queries_path
    click_link 'Delete'
    expect(page).to have_content('Query destroyed!')
  end
end

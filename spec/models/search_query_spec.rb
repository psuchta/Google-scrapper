describe SearchQuery, :vcr do
  describe '#create_with_results' do
    context 'with string parameter' do
      let(:searched_quote) { 'Rails' }
      let(:google_query) do
        SearchQuery.create_with_results(search_query_params: { searched_quote: searched_quote })
      end

      it 'creates search_query object' do
        expect { google_query }.to change { SearchQuery.count }.by(1)
      end

      it 'creates query_results objects' do
        expect { google_query }.to change { QueryResult.count }.by(15)
      end

      it 'creates search_query object with correct attributes' do
        expect(google_query).to have_attributes(searched_quote: searched_quote)
      end
    end

    context 'with empty searched_quote parameter' do
      let(:empty_google_query) do
        SearchQuery.create_with_results(search_query_params: { searched_quote: '' })
      end

      it 'creates search_query object' do
        expect { empty_google_query }.to change { SearchQuery.count }.by(1)
      end

      it 'doesnt create query_results objects' do
        expect { empty_google_query }.to change { QueryResult.count }.by(0)
      end
    end
  end

  describe '.update_or_create_query_results' do
    context 'when new search result occured' do
      it 'creates new query_result objects' do
        search_query = create(:search_query_with_query_results,
                               searched_quote: 'Rails')
        expect { search_query.update_or_create_query_results }
          .to change { QueryResult.count }.by(15)
      end
    end

    context 'when same searched results occured' do
      it 'updates existing query_result object' do
        search_query = create(:search_query, searched_quote: 'Rails')
        query_result = search_query.query_results.create!(attributes_for(:query_result,
                                                                         link: 'https://rubyonrails.org/'))
        expect { search_query.update_or_create_query_results }
          .to change { query_result.reload.text }
          .and change { QueryResult.count }.by(14)
      end
    end
  end
end

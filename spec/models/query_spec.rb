describe Query do
  describe '#create_with_results' do
    context 'with string parameter' do
      let(:searched_quote) { 'Rails' }
      let(:google_query) do
        Query.create_with_results(query_params: { searched_quote: 'Rails' })
      end

      it 'creates query object', :vcr do
        expect { google_query }.to change { Query.count }.by(1)
      end

      it 'creates query_results objects', :vcr do
        expect { google_query }.to change { QueryResult.count }.by(15)
      end
    end

    context 'with empty searched_quote parameter' do
      let(:empty_google_query) do
        Query.create_with_results(query_params: { searched_quote: '' })
      end
      it 'creates query object', :vcr do
        expect { empty_google_query }.to change { Query.count }.by(1)
      end

      it 'doesnt create query_results objects', :vcr do
        expect { empty_google_query }.to change { QueryResult.count }.by(0)
      end
    end
  end

  describe '.update_or_create_query_results' do

    context 'when new search result occured' do
      it 'creates new query_result objects', :vcr do
        query =  create(:query_with_query_results,
                        searched_quote: 'Rails')
        expect { query.update_or_create_query_results }
          .to change { QueryResult.count }.by(15)
      end
    end

    context 'when same searched results occured' do
      it 'updates existing query_result object', :vcr do
        query = create(:query, searched_quote: 'Rails')
        query_result = query.query_results.create!(attributes_for(:query_result,
                                                                  link: 'https://rubyonrails.org/'))
        expect { query.update_or_create_query_results }
          .to change { query_result.reload.text }
          .and change { QueryResult.count }.by(14)
      end
    end
  end
end

describe 'SearchQueries Management', type: :request do
  describe 'GET search_queries#index' do
    it 'gets successful response' do
      search_queries = create_list(:search_query, 2)
      get search_queries_path
      expect(response).to be_successful
    end
  end

  describe 'POST search_queries#create' do
    let(:create_action) { post search_queries_path, params: params }

    context 'with valid params' do
      let(:params) do
        {
          search_query: { searched_quote: 'Rails' }
        }
      end

      it 'creates objects and redirects to search_queries#index', :vcr do
        expect { create_action }.to change(SearchQuery, :count).by(1)
          .and change(QueryResult, :count).by(15)
        expect(response).to redirect_to(search_queries_path)
      end
    end
  end

  describe 'DELETE search_queries#destroy' do
    let(:delete_action) { delete search_query_path(query), params: { id: query } }
    let!(:query) { create(:search_query_with_query_results, query_results_count: 3) }

    it 'deletes the objects and redirects to search_queries#index' do
      expect { delete_action }.to change(SearchQuery, :count).by(-1)
        .and change(QueryResult, :count).by(-3)
      expect(response).to redirect_to(search_queries_path)
    end
  end
end

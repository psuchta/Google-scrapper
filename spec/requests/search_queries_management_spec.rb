describe 'SearchQueries Management' do
  describe 'GET #index' do
    it 'gets successful response' do
      search_queries = create_list(:search_query, 2)
      get search_queries_path
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'gets successful response' do
      search_query = create(:search_query)
      get search_query_path(search_query)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'gets successful response' do
      search_query = create(:search_query)
      get edit_search_query_path(search_query)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:create_action) { post search_queries_path, params: params }

    context 'with valid params' do
      let(:params) do
        {
          search_query: { searched_quote: 'Rails' }
        }
      end

      it 'creates objects and redirects to #index', :vcr do
        expect { create_action }.to change(SearchQuery, :count).by(1)
          .and change(QueryResult, :count).by(15)
        expect(response).to redirect_to(search_queries_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:query) { create(:search_query_with_query_results, query_results_count: 3) }
    let(:delete_action) { delete search_query_path(query)}

    it 'deletes the objects and redirects to #index' do
      expect { delete_action }.to change(SearchQuery, :count).by(-1)
        .and change(QueryResult, :count).by(-3)
      expect(response).to redirect_to(search_queries_path)
    end
  end

  describe 'PUT #update', :vcr do
    let!(:query) { create(:search_query_with_query_results, query_results_count: 3) }
    let(:params) do
      {
        search_query: { searched_quote: 'Rails' }
      }
    end
    let(:update_action) { put search_query_path(query), params: params }

    it 'updates search query and redirects to #index' do
      expect { update_action }.to change(QueryResult, :count).by(12)
      expect(response).to redirect_to(search_queries_path)
    end
  end
end

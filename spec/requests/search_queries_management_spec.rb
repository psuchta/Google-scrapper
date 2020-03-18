describe 'SearchQueries Management', type: :request do
  describe 'GET search_queries#index' do
    it 'renders the :index view' do
      search_queries = create_list(:search_query, 2)
      get search_queries_path
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
      expect(assigns(:search_queries)).to eq(search_queries)
    end
  end

  describe 'POST search_queries#create' do
    subject { post search_queries_path, params: params }

    context 'with valid params' do
      let(:params) do
        {
          search_query: { searched_quote: 'Rails' }
        }
      end

      it 'creates objects and redirects to search_queries#index', :vcr do
        expect { subject }.to change(SearchQuery, :count).by(1)
          .and change(QueryResult, :count).by(15)
        expect(response).to redirect_to(search_queries_path)
      end
    end
  end

  describe 'DELETE search_queries#destroy' do
    subject { delete search_query_path(query), params: { id: query } }
    let!(:query) { create(:search_query_with_query_results, query_results_count: 3) }

    it 'deletes the objects and redirects to search_queries#index' do
      expect { subject }.to change(SearchQuery, :count).by(-1)
        .and change(QueryResult, :count).by(-3)
      expect(response).to redirect_to(search_queries_path)
    end
  end
end

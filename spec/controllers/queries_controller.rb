describe QueriesController do
  describe 'GET index' do
    it 'returns 200 http status' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders the :index view' do
      queries = create_list(:query, 2)
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:queries)).to eq(queries)
    end
  end

  describe 'POST create' do
    subject { post :create, params: params}

    let(:params) do
      {
        query: { searched_quote: 'Rails' }
      }
    end

    it 'returns 302 http status', :vcr do
      subject
      expect(response.status).to eq(302)
    end

    it 'creates a new query and query_results', :vcr do
      expect { subject }.to change(Query, :count).by(+1)
      .and change(QueryResult, :count).by(+15)
    end

    it 'redirects to :index', :vcr  do
      subject
      expect(response).to redirect_to(queries_path)
    end
  end

  describe 'DELETE destroy' do
    let!(:query) { create(:query_with_query_results, query_results_count: 3) }

    it 'deletes the query' do
      expect { delete :destroy, id: query }.to change(Query, :count).by(-1)
    end

  end
end

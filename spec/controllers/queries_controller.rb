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
    subject { post :create, params: params }

    context 'with valid params' do
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

      it 'redirects to queries#index', :vcr do
        subject
        expect(response).to redirect_to(queries_path)
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: { id: query } }
    let!(:query) { create(:query_with_query_results, query_results_count: 3) }

    it 'deletes the query and query_results' do
      expect { subject }.to change(Query, :count).by(-1)
        .and change(QueryResult, :count).by(-3)
    end

    it 'redirects to queries#index' do
      subject
      expect(response).to redirect_to(queries_path)
    end
  end
end

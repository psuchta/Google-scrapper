describe QueryResult do
  describe '#create_or_update_result' do
    let(:query) { create(:query) }
    let(:query_results_attr) { attributes_for(:query_result) }

    it 'returns QueryResult object' do
      query_result = QueryResult.create_or_update_by_link!(query_id: query.id,
                                                           text: query_results_attr[:text],
                                                           link: query_results_attr[:link])
      expect(query_result.class).to be(QueryResult)
    end

    context 'when query_result doesnt exist' do
      it 'creates query_result record' do
        expect do
          QueryResult.create_or_update_by_link!(query_id: query.id,
                                                text: query_results_attr[:text],
                                                link: query_results_attr[:link])
        end
          .to change { QueryResult.count }
          .by(1)
      end

      it 'created query_result has correct attributes' do
        query_result = QueryResult.create_or_update_by_link!(query_id: query.id,
                                                             text: query_results_attr[:text],
                                                             link: query_results_attr[:link])
        expect(query_result).to have_attributes(text: query_results_attr[:text],
                                                link: query_results_attr[:link])
      end
    end

    context 'when query_result exists' do
      it 'updates existed query_result record' do
        query_result = create(:query_result, query: query)
        new_title = 'New title 41243'
        QueryResult.create_or_update_by_link!(query_id: query.id,
                                              text: new_title,
                                              link: query_result.link)
        expect(query_result.reload).to have_attributes(text: new_title)
      end
    end

    context 'with query_id that doesnt exist' do
      it 'raises error' do
        query_result = create(:query_result, query: query)
        expect do
          QueryResult.create_or_update_by_link!(query_id: 4112412,
                                                text: query_result[:text],
                                                link: query_result[:link])
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

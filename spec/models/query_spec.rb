require 'rails_helper'

RSpec.describe Query, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:query_results) }
  end

  describe '#create_with_results' do
    context 'with string parameter' do
      let (:google_query) { Query.create_with_results({ searched_quote: 'Rails' }) }

      it 'creates query object' do
        VCR.use_cassette('google_query') do
          expect{ google_query }.to change{ Query.count }.from(0).to(1)
        end
      end

      it 'creates query_results objects' do
        VCR.use_cassette('google_query') do
          expect{ google_query }.to change{ QueryResult.count }.by_at_least(5)
        end
      end
    end

    context 'with empty parameter' do
      let (:empty_google_query) { Query.create_with_results({ searched_quote: '' }) }

      it 'creates query object' do
        VCR.use_cassette('empty_google_query') do
          expect{ empty_google_query }.to change{ Query.count }.from(0).to(1)
        end
      end

      it 'doesnt create query_results objects' do
        VCR.use_cassette('empty_google_query') do
          expect{ empty_google_query }.to change{ QueryResult.count }.by(0)
        end
      end
    end
  end

  describe '.update_or_create_query_results' do
    let(:google_searcher) { instance_double('GoogleLinksSearcher')}

    context 'when new search result occured' do
      it 'create new query_result objects' do
        query = create(:query_with_query_results)
        search_results = [GoogleSearcherResult.new('Title', 'www.wp.pl')]
        allow(google_searcher).to receive(:run_query).with(query.searched_quote).and_return(search_results)
        expect{ query.update_or_create_query_results(google_searcher) }.to change{ QueryResult.count }.by(1)
      end
    end

    context 'when one title was updated' do
      it 'update present objects' do
        query = create(:query_with_query_results)
        search_results = [GoogleSearcherResult.new('Title', 'www.wp.pl')]
        allow(google_searcher).to receive(:run_query).with(query.searched_quote).and_return(search_results)
        expect{ query.update_or_create_query_results(google_searcher) }.to change{ QueryResult.count }.by(1)
      end
    end
  end
end
describe GoogleLinksSearcher do
  describe '.run_query' do
    let(:google_searcher) { GoogleLinksSearcher.new }

    context 'with string parameter' do
      it 'returns correct number of links', :vcr do
        results = google_searcher.run_query('Rails')
        expect(results.count).to eq(16)
      end
    end

    context 'with empty parameter' do
      it 'returns correct number of links', :vcr do
        results = google_searcher.run_query('')
        expect(results.count).to eq(0)
      end
    end

    context 'with number parameter ' do
      it 'returns correct number of links', :vcr do
        results = google_searcher.run_query(2137)
        expect(results.count).to eq(11)
      end
    end
  end
end

class GoogleLinksSearcher
  def run_query(query)
    search_results = get_google_query(query)
    strip_links(search_results)
  end

  private

  def get_google_query(query)
    search_results = nil
    agent = Mechanize.new
    agent.get('https://www.google.pl/') do |page|
      search_results = page.form('f') do |google_form|
        google_form.q = query.to_s
      end.submit
    end
    search_results
  end

  def strip_links(search_results)
    only_serching_results = search_results.links.select { |link| link.href.include?('/url?q=') }
    only_serching_results.map do |link|
      url = link.href.to_s
      url = url.split(%r{=|&})[1]
      OpenStruct.new(text: link.text, link: url)
    end
  end
end

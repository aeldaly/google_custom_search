require 'spec_helper'

describe GoogleCustomSearch do
  it "should return an array of results" do
    results = GoogleCustomSearch.search('wine')
    results.pages.should_not be_empty
    # results.labels.should_not be_empty
    results.time.is_a?(Float).should be_true
    results.total.is_a?(Fixnum).should be_true
    results.time.should be > 0
    results.total.should be > 0

    results.pages.each do |page|
      page.title.is_a?(String).should be_true
      page.title.should_not be_empty

      page.url.is_a?(String).should be_true
      URI.parse(page.url)

      page.description.is_a?(String).should be_true
      page.description.should_not be_empty
    end
    # (label_set & results.labels.keys.to_set).should_not be_empty
  end
end


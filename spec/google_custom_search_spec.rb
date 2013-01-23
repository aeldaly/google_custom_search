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

  it "should paginate" do
    page1 = GoogleCustomSearch.search('wine')
    page2 = GoogleCustomSearch.search('wine', 2)

    page1.pages.first.url.should_not eql(page2.pages.first.url)
  end

  it "should return 10 results by default" do
    GoogleCustomSearch.search('wine').pages.size.should eql(10)
  end

  it "should max out at 10 results even if a bigger number is supplied" do
    GoogleCustomSearch.search('wine', 1, 30).pages.size.should eql(10)
  end

  it "should return 5 results if asked to" do
    GoogleCustomSearch.search('wine', 1, 5).pages.size.should eql(5)
  end
end


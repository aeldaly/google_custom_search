##
# Single search result.
#
class GoogleCustomSearch::Result
  attr_reader :url, :title, :description, :labels

  def self.parse(res_r)
    res_r = [res_r] if res_r.is_a?(Hash)

    res_r.collect do |r|
      self.new(
        r['link'],
        r['htmlTitle'],
        r['htmlSnippet']
        # r['Label'].is_a?(String) ? [r['Label']] : r['Label']) # array of labels
      )
    end
  end

  def initialize(url, title, description, labels = nil)
    @url, @title, @description, @labels = url, title, description, labels
  end
end


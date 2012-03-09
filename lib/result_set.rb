##
# Simple class to hold a collection of search result data.
#
class GoogleCustomSearch::ResultSet
  attr_reader :time, :total, :pages, :suggestion, :labels, :current_page, :limit_value, :num_pages

  def self.create(xml_hash, page, per_page)
    self.new(xml_hash['TM'].to_f,
             xml_hash['RES']['M'].to_i,
             parse_results(xml_hash['RES']['R']),
             spelling = xml_hash['SPELLING'] ? spelling['SUGGESTION'] : nil,
             parse_labels(xml_hash),
             page, per_page)
  end

  def self.create_empty
    self.new(0.0, 0, [], nil, {})
  end

  def self.parse_results(res_r)
    GoogleCustomSearch::Result.parse(res_r)
  end

  def self.parse_labels(xml_hash)
    return {} unless context = xml_hash['Context'] and facets = context['Facet']
    facets.map do |f|
      (fi = f['FacetItem']).is_a?(Array) ? fi : [fi]
    end.inject({}) do |h, facet_item|
      facet_item.each do |element|
        h[element['label']] = element['anchor_text']
      end
      h
    end
  end

  def initialize(time, total, pages, suggestion, labels, page = 1, per_page = 20)
    @time, @total, @pages, @suggestion, @labels, @current_page = time, total, pages, suggestion, labels, page
    @limit_value = per_page
    @num_pages = (total / per_page).ceil
  end
  
end
  

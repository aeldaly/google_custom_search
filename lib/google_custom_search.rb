##
# Add search functionality (via Google Custom Search). Protocol reference at:
# http://www.google.com/coop/docs/cse/resultsxml.html
#
require 'open-uri'
require 'timeout'
require 'active_support/core_ext'

module GoogleCustomSearch
  autoload :ResultSet, 'result_set'
  autoload :Result, 'result'
  autoload :GcsConfig, 'gcs_config'

  extend self

  ##
  # Search the site.
  #
  def search(query, page = 1, length = 20)
    offset = page * length
    
    # Get and parse results.
    url = url(query, offset, length)
    return nil unless data = fetch(url)
    
    # Extract and return search result data, if exists.
    if data['items'].present?
      ResultSet.create(data, offset, length)
    else
      ResultSet.create_empty()
    end
  end
  
  private # -------------------------------------------------------------------
  
  ##
  # Build search request URL.
  #
  def url(query, offset = 0, length = 20)
    params = {
      :q      => query,
      # :start  => offset,
      # :num    => length,
      # :client => "google-csbe",
      # :output => "xml_no_dtd"
    }
    params.merge!(GcsConfig.new.get_config)
    
    begin
      params.merge!(GOOGLE_SEARCH_PARAMS)
    rescue NameError
    end
    "https://www.googleapis.com/customsearch/v1?" + params.to_query
  end
  
  ##
  # Query Google, and make sure it responds.
  #
  def fetch(url)
    puts url if $debug
    begin
      resp = nil
      Timeout::timeout(3) do
        resp = open(url)
      end
    rescue Timeout::Error; end
    if resp and resp.status.first == "200"
      response = resp.read
      JSON.parse(response)
    else
      nil
    end
  end
end

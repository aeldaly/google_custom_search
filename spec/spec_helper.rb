require 'rubygems'
require 'bundler/setup'

require 'kaminari'
require 'google_custom_search'

# Google Custom Search (Google Jobs) :)
# GOOGLE_SEARCH_CX = '016766180714503271468:t099t-w3qse'

# IBM Magazine
# GOOGLE_SEARCH_CX = '003630504832992121813:duvzt8xkd_8'

# fbi.gov
# GOOGLE_SEARCH_CX = '004748461833896749646:e41lgwqry7w'

# winealign.com
GCS_CONFIG = {
  cx: '004261898804431608949:ojhwkepzgd0',
  key: 'AIzaSyBRXPxQK1FzWW5MsDP-2pHI8Vp-LpxC-Dg',
  h1: 'lang_en',
  c2coff: 1
}

# Print URLs
$debug = true

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

class GcsConfig

  attr_reader :cx, :key, :h1, :c2coff

  def initialize
    @cx     = GCS_CONFIG[:cx]
    @key    = GCS_CONFIG[:key]
    @h1     = GCS_CONFIG[:h1]     || 'lang_en'
    @c2coff = GCS_CONFIG[:c2coff] || 1
  end

  def get_config
    return @config if defined?(@config)

    @config = {
      cx:     @cx,
      key:    @key,
      h1:     @h1,
      c2coff: @c2coff
    }
  end

end
class SodaAPI
  attr_reader :response
  def initialize
    @client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => Rails.application.secrets.movie_app_token})
    @options = {}
  end

  def get
    @response = @client.get(
      Rails.application.secrets.endpoint,
      @options
    )
  end

  def options=(hash)
    hash.each do |k, v|
      k = ('$' + k.to_s)
      @options[k] = v
    end
  end

  def options
    @options
  end

  def test_options
    self.options=({limit: 10, where: "title='180'"})
  end
end

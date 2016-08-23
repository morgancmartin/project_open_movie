class SodaAPI
  attr_reader :response, :exact
  def initialize
    @client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => Rails.application.secrets.movie_app_token})
    @options = {}
    @exact = false
  end

  def toggle_exact
    @exact = !@exact
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

  def add_where_like_arg(col_name, var)
    var.downcase!
    if options['$where']
      options['$where'] += " AND lower(#{col_name}) like '%#{var}%'"
    else
      options['$where'] = "lower(#{col_name}) like '%#{var}%'"
    end
  end

  # case insensitive
  def add_where_exact_arg(col_name, var)
    var.downcase!
    if options['$where']
      options['$where'] += " AND lower(#{col_name})='%#{var}%'"
    else
      options['$where'] = "lower(#{col_name})='%#{var}%'"
    end
  end

  def add_where_like_arg_or(col_name, var)
    var.downcase!
    if options['$where']
      options['$where'] += " OR lower(#{col_name}) like '%#{var}%'"
    else
      options['$where'] = "lower(#{col_name}) like '%#{var}%'"
    end
  end

  def add_where_exact_arg_or(col_name, var)
    var.downcase!
    if options['$where']
      options['$where'] += " OR lower(#{col_name})='%#{var}%'"
    else
      options['$where'] = "lower(#{col_name})='%#{var}%'"
    end
  end

  def add_release(year)
    if @exact
      add_where_exact_arg('release_year', year)
    else
      add_where_like_arg('relase_year', year)
    end
  end

  def add_title(title)
    if @exact
      add_where_exact_arg('title', title)
    else
      add_where_like_arg('title', title)
    end
  end

  def add_top_three_actor(actor)
    if @exact
      3.times { |i| add_where_exact_arg_or("actor_#{i+1}", actor) }
    else
      3.times { |i| add_where_like_arg_or("actor_#{i+1}", actor) }
    end
  end

  def add_lead_actor(actor)
    if @exact
      add_where_exact_arg('actor_1', actor)
    else
      add_where_like_arg('actor_1', actor)
    end
  end

  def add_production_comp(company)
    if @exact
      add_where_exact_arg('production_company', company)
    else
      add_where_like_arg('production_company', company)
    end
  end

  def add_loc(loc)
    if @exact
      add_where_exact_arg('locations', loc)
    else
      add_where_like_arg('locations', loc)
    end
  end

  def reset_options
    @options = {}
  end
end

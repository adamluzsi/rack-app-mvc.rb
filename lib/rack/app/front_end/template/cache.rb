class Rack::App::FrontEnd::Template::Cache
  def initialize
    @cache = {}
  end

  # Caches a value for key, or returns the previously cached value.
  # If a value has been previously cached for key then it is
  # returned. Otherwise, block is yielded to and its return value
  # which may be nil, is cached under key and returned.
  # @yield
  # @yieldreturn the value to cache for key
  def fetch(*key)
    @cache.fetch(key) do
      @cache[key] = yield
    end
  end

  # Clears the cache.
  def clear
    @cache = {}
  end
end

module Net
  class HTTP
    def self.get_response(url)
      Mock::Response.new(url)
    end
  end
end

module Mock
  class Response
    def initialize(url)
      @url = url
    end

    def body
      self
    end

    def sum
      @url.hash
    end
  end
end


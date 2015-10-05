class KickboxApi
  def initialize opts = {}
    @token = opts[:token]
    @end_point = opts[:end_point]
    @url = opts[:url]

    raise ArgumentError if @token.nil? || @end_point.nil? || @url.nil?

    @conn = Faraday.new(@url) do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def verify email
    email = CGI.escape(email) #Prepare email for URL encoding
    begin
      response = @conn.get do |req|
        req.url "#{@end_point}?email=#{email}&apikey=#{@token}"
        req.options.timeout = 2
        req.options.open_timeout = 2
      end
      if response.status == 200
        JSON.parse(response.body) if response.body.is_a? String
      end
    rescue
      {'success' => 'false'}
    end
  end
end

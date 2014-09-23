class FacebookPageFetcher
  include HTTParty
  format :json
  base_uri 'https://graph.facebook.com'

  def initialize(token)
    @token = token
  end

  def find(page_id)
    response = self.class.get("/#{page_id}")
    if response.header.is_a? Net::HTTPOK
      hash = response.parsed_response
      res = {facebook_id: hash['id'], name: hash['name']}
      res['profile_picture'] = self.get_picture(page_id)
      res
    else
      nil
    end
  end

  def get_picture(page_id)
    response = self.class.get("/#{page_id}/picture?redirect=false")
    if response.header.is_a? Net::HTTPOK
      hash = response.parsed_response
      hash['data']['url']
    else
      ""
    end
  end

  def get_feed(page_id)
    response = self.class.get("/#{page_id}/feed?access_token=#{@token}")
    if response.header.is_a? Net::HTTPOK
      data = response.parsed_response['data']
      data.map do |post|
        { facebook_id: post['id'], name: post['name'], picture: post['picture'],
          message: post['message'], description: post['description'] }
      end
    else
      []
    end
  end
end


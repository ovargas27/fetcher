class PageFetcher
  include HTTParty
  format :json
  base_uri 'http://graph.facebook.com'

  def self.find(page_id)
    response = self.get("/#{page_id}")
    if response.header.is_a? Net::HTTPOK
      hash = response.parsed_response
      res = {facebook_id: hash['id'], name: hash['name']}
      res['profile_picture'] = self.get_picture(page_id)
      res
    else
      nil
    end
  end

  def self.get_picture(page_id)
    response = self.get("/#{page_id}/picture?redirect=false")
    if response.header.is_a? Net::HTTPOK
      hash = response.parsed_response
      hash['data']['url']
    else
      ""
    end
  end
end


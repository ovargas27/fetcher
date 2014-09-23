class PageFetcher
  include HTTParty
  format :json
  base_uri 'https://graph.facebook.com'

  attr_accessor :page

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

  def self.get_feed(page_id)
    token = "CAADFZAIL8xY8BAIo7G26zlIWXgNXy1LyAgyUZBuRAdn8TPzwiW0S4BBSH7tns4ww9D7YBRv8dQqZAeNsOHug8PBi64NLGFmsLNvGziRmOAp1RhSqNNxZBk8sdjm1I8ZBRsC1bRG5ph36hso0hbtULzN9BiWJTIV8Hmq04ZBZAKsaMlJ55XofE4m87w6qWhcOCvJHYFiVT4Km98MnrckJZAp4nswmIov6abkZD"
    response = self.get("/#{page_id}/feed?access_token=#{token}")
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


class Page < ActiveRecord::Base
  validates :facebook_id, :profile_picture, :name, presence: true
  validates :facebook_id, uniqueness: true

  has_many :posts

  def self.search(options)
    page_hash = PageFetcher.find(options[:facebook_id])
    page = Page.new page_hash
    if page.save
      page.get_feed
      page
    end
  end

  def get_feed
    posts_arr = PageFetcher.get_feed(facebook_id)
    posts_arr.each do |hash|
      post = self.posts.build(hash)
      post.save
    end
  end
end


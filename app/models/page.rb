class Page < ActiveRecord::Base
  validates :facebook_id, :profile_picture, :name, presence: true
end

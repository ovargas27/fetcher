class Post < ActiveRecord::Base
  validate :name, :picture, presence: true

  belongs_to :page
end

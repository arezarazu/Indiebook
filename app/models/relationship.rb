class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :listing
end

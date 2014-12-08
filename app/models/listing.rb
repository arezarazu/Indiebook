class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "300x", :thumb => "100x100>" }, :default_url => "default.gif"
	else
  	has_attached_file :image, :styles => { :medium => "300x", :thumb => "100x100>" }, :default_url => "default.gif", 
  							:storage => :dropbox,
    						:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    						:path => ":style/:id_:filename"
  end
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :name, :price, presence: true
	validates :price, numericality: { greater_than: 0 }
	validates_attachment_presence :image

	belongs_to :user
  has_many :orders
  has_many :reviews

  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "listing_id",
                                  dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
end

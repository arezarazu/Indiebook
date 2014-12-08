class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  has_many :reviews, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
  																foreign_key: "follower_id",
  																dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :listing

  #Follow a listing
  def follow(listing)
  	active_relationships.create(listing_id: listing.id)
  end

  #Unfollow a listing
  def unfollow(listing)
  	active_relationships.find_by(listing_id: listing.id).destroy
  end

  # Returns true if the current user is following the listing
  def following?(listing)
  	following.include?(listing)
  end
end

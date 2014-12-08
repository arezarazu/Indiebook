class RelationshipsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
    current_user.follow(@listing)
    respond_to do |format|
    	format.html { redirect_to @listing }
    	format.js
    end
  end

  def destroy
  	@listing = Relationship.find(params[:id]).listing
    current_user.unfollow(@listing)
    respond_to do |format|
    	format.html { redirect_to @listing }
    	format.js
    end
  end
end

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_listing

  respond_to :html

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.listing_id = @listing.id

    flash[:notice] = "Review was successfully created." if @review.save 
    respond_with(@review, :location => listing_path(@listing)) 
  end

  def update
    @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    respond_with(@review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end

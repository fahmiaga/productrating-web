class ReviewsController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @review = Review.new
      @purchase = Purchase.find(params["review"][:purchase_id])
    end
  end

  def new
    @review.assign_attributes(review_params)
  end

  def create
    # TODO: Create the record in database

    @review.assign_attributes(review_params)
    if @review.save
      redirect_to product_purchase_url(@purchase.product_id, @purchase.id)
    else
      flash[:error] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:purchase_id,:rating,:comment)
    end
end

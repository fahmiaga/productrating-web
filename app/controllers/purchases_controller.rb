class PurchasesController < ApplicationController
  before_action do
    @product = Product.find(params[:product_id])

    case action_name.to_sym
    when :new, :create
      @purchase = @product.purchases.new
    when :show, :edit, :destroy, :update
      @purchase = @product.purchases.find(params[:id])
    end
  end

  def new
  end

  def create
    # TODO: Also decrease product quantity.
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)

    if @purchase.check_quantity(@product, purchase_params[:quantity].to_i)
      return render :new  
    end
    
    product_safe = @product.increment(:quantity, @product.id) 
    new_quantity = product_safe.quantity - 4 - purchase_params[:quantity].to_i

    @purchase.assign_attributes(purchase_params)
    if @purchase.save
       @product.update(:quantity => new_quantity)
       redirect_to product_url(@product)
    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # TODO: Show edit form
   
  end

  def update
    # TODO: Update record (save to database)
   
    if @purchase.check_quantity(@product, purchase_params[:quantity].to_i)
      return render :new  
    end
    
    new_quantity = @product.quantity - purchase_params[:quantity].to_i

    if @purchase.update(purchase_params)
      @product.update(:quantity => new_quantity)
      redirect_to product_url(@product)
    else
      render :edit
    end
  end

  def destroy
    # TODO: Delete record
    @purchase.destroy
    redirect_to product_url(@product)

  end

  def show
  end

  private
    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end  

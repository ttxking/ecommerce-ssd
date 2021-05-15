class OrdersController < ApplicationController
    def new
        @order = Order.new
      end
  
      # POST /products or /products.json
    def create
        @order = Order.new(order_params)
  
        respond_to do |format|
          if @order.save
            format.html { redirect_to homes_path, notice: "Order was successfully created." }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
    end

    private 

    def order_params
      params.require(:order).permit(:name, :address, :product, :amount)
    end
end

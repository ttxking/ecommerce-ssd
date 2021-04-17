module Admins
  class ProductsController < ApplicationController 
    before_action :set_product, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, except: [:index, :show]



    # GET /products or /products.json
    def index
      @products = Product.all

      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(Product.all), file_name: 'products.csv'}
      end
    end

    # GET /products/new
    def new
      @product = Product.new

      @category = Category.all

      @product_category = @product.product_categories.build
    end

    # POST /products or /products.json
    def create
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to action: :index, notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admins_product_url, notice: "Product was successfully updated." }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to admins_products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def csv_upload
      data = params[:csv_file].read.split("\n")
      data.each do |line| 
        attribute = line.split(",").map(&:strip)
        Product.create title: attribute[0], description: attribute[1], stock: attribute[2]
      end
      redirect_to action: :index
    end 

    def delete_image
      image = ActiveStorage::Attachment.find(params[:id])
      image.purge
      redirect_to action: :index
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end

      def generate_csv(products)
        products.map { |p| [p.title, p.description, p.created_at].join(',') }.join("\n")
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:status, :title, :description, :stock, :primary_image, category_ids: [], images: [])
      end
  end
end
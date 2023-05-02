class ProductModelsController < ApplicationController
  before_action :set_product_model, only: %i(show)

  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new product_model_params

    return redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.' if @product_model.save

    @suppliers = Supplier.all
    flash[:alert] = 'Não foi possível cadastrar o modelo de produto'
    render 'new'
  end

  def show; end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model)
          .permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end

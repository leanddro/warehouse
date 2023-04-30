class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i(show edit update)

  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    return redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso' if @supplier.save

    flash[:alert] = 'Fornecedor não cadastrado'
    render 'new'
  end

  def show; end
  def edit; end

  def update
    return redirect_to @supplier, notice: 'Fornecedor atualizado com sucesso' if @supplier.update(supplier_params)

    flash.now[:alert] = 'Não foi possível atualizar o fornecedor'
    render 'edit'
  end

  private

  def set_supplier
     @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier)
          .permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end
end

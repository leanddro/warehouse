class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i(show edit update destroy)

  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    return redirect_to root_path, notice: 'Galpão cadastrado com sucesso.' if @warehouse.save

    flash[:alert] = 'Galpão não cadastrado.'
    render 'new'
  end

  def edit; end

  def update
    return redirect_to @warehouse, notice: 'Galpão atualizado com sucesso' if @warehouse.update(warehouse_params)

    flash.now[:alert] = 'Não foi possível atualizar o galpão'
    render 'edit'
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: 'Galpão removido com sucesso'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse)
                  .permit(:name, :code, :city, :description, :address, :cep, :area)
  end
end

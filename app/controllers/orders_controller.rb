class OrdersController < ApplicationController
  before_action :set_order_and_check_user, only: %i(show edit update delivered canceled)

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new order_params
    @order.user = current_user
    return redirect_to @order, notice: 'Pedido registrado com sucesso' if @order.save

    flash[:alert] = 'Não foi possível registra o pedido'
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    render 'new'
  end

  def show; end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order.update order_params

    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
      end
    end
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
    if @orders.length == 1
      return redirect_to @orders.first if @orders.first.code == @code
    end
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    return redirect_to root_path, alert: 'Você não possui acesso a este pedido.' if @order.user != current_user
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end

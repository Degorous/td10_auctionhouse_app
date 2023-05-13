class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lot, only: [:show]

  def show;end

  def new
    @lot = Lot.new
  end

  def create
    @lot = Lot.new(lot_params)
    if @lot.save
      @lot.started_by = current_user
      redirect_to @lot, notice: 'Lote criado com sucesso'
    else
      flash.now[:notice] = "Não foi possível criar o Lote"
      render 'new'
    end
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:code, :start_date, :finish_date, :start_bid, :increase_bid)
  end
end
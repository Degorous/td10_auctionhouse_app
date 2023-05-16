class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :approved, :bid]

  def index
    @lots_ongoing = Lot.approved.where("finish_date >= :current_date AND start_date <= :current_date", current_date: Date.current)
    @lots = Lot.pending
  end

  def show;end

  def new
    @lot = Lot.new
  end

  def create
    @lot = Lot.new(lot_params)
    @lot.lot_creator = current_user
    if @lot.save
      redirect_to @lot, notice: 'Lote criado com sucesso'
    else
      flash.now[:notice] = "Não foi possível criar o Lote"
      render 'new'
    end
  end

  def approved
    @lot.approved!
    redirect_to @lot
  end

  def bid
    @lot.bid = params[:lot][:bid]
    @lot.bid_user = current_user
    if @lot.save
      redirect_to @lot, notice: 'Lance efetuado com sucesso'
    else
      redirect_to @lot, notice: @lot.errors.full_messages.join
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
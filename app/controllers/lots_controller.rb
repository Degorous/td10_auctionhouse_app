class LotsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin, only: [:new, :create, :expired]
  before_action :authenticate_user!, only: [:winner]
  before_action :set_lot, only: [:show, :approved, :bid, :closed]

  def index
    @lots_ongoing = Lot.ongoing
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
      redirect_to @lot, notice: @lot.errors.full_messages.join #Teste unitário para lances e lógica primeiro lance
    end
  end

  def expired
    @lots = Lot.expired
  end

  def closed
    if @lot.bid_user == nil
      @lot.canceled!
      lot_items = @lot.lot_items
      lot_items.destroy_all

      redirect_to @lot, notice: "Esse lote foi cancelado"
    else
      @lot.finished!
      redirect_to @lot, notice: 'Lote finalizado'
    end
  end
  
  def winner
    @user_lots = current_user.lots
    @lots_finished = Lot.finished
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:code, :start_date, :finish_date, :start_bid, :increase_bid)
  end

  def authenticate_admin
    if !current_user.admin?
      redirect_to new_user_session_path
    end
  end
end
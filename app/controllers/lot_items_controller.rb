class LotItemsController < ApplicationController
  def new
    @lot = Lot.find(params[:lot_id])
    @items = Item.left_outer_joins(:lot).where(lot: {id: nil})
    
    @lot_item = LotItem.new
  end

  def create
    @lot = Lot.find(params[:lot_id])
    lot_item_params = params.require(:lot_item).permit(:item_id)
    @lot.lot_items.create(lot_item_params)

    redirect_to @lot, notice: 'Item adicionado com sucesso'
  end

  def destroy
    @lot = Lot.find(params[:lot_id])
    @lot_item = @lot.lot_items.find(params[:id])
    @lot_item.destroy
    
    redirect_to @lot, notice: 'Item removido com sucesso'
  end
end
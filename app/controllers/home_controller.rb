class HomeController < ApplicationController
  def index
    @lots_approved = Lot.approved
    @lots_pending = Lot.pending
  end
end
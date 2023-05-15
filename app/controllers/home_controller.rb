class HomeController < ApplicationController
  def index
    @lots_ongoing = Lot.approved.where("finish_date >= :current_date AND start_date <= :current_date", current_date: Date.current)
    @lots_future = Lot.approved.where("start_date > ?", Date.current)
  end
end
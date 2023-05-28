class HomeController < ApplicationController
  def index
    @lots_ongoing = Lot.ongoing
    @lots_future = Lot.future
  end
end
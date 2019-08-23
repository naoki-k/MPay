class TradesController < ApplicationController
  def new
    @trade = Trade.new
  end

  def create

  end

  private

    def trade_params
      params.require(:trade).permit()
    end
end

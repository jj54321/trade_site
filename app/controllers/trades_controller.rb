class TradesController < ApplicationController

  def index
    @trades = Trade.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @trades}
    end
  end

  def instrument
    @trades = Trade.find_by_instrument(params[:instrument])
  end

  def show
    @trade = Trade.find(params[:id])
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @trade}
    end
  end
end

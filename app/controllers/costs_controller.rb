class CostsController < ApplicationController
  def index
    @costs = Cost.all
  end

  def new
    @cost = Cost.new
  end

  def create
    cost = Cost.new(cost_params)
    cost.save!
    redirect_to costs_url, notice: "支出「#{cost.name}」を登録しました"
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

    def cost_params
      params.require(:cost).permit(:name, :price, :description)
    end
end

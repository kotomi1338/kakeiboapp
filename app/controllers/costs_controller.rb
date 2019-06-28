class CostsController < ApplicationController
  def index
    @costs = Cost.all
  end

  def new
    @cost = Cost.new
  end

  def create
    @cost = Cost.new(cost_params)
    if @cost.save
      redirect_to costs_url, notice: "支出「#{@cost.name}」を登録しました"
    else
      render :new
    end
  end

  def show
    @cost = Cost.find(params[:id])
  end

  def edit
    @cost = Cost.find(params[:id])
  end

  def update
    cost = Cost.find(params[:id])
    cost.update!(cost_params)
    redirect_to costs_url, notice: "支出「#{cost.name}」を更新しました"
  end

  def destroy
    cost = Cost.find(params[:id])
    cost.destroy
    redirect_to costs_url, notice: "支出「#{cost.name}」を削除しました。"
  end

  private

    def cost_params
      params.require(:cost).permit(:name, :price, :description)
    end
end

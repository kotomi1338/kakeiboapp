class CostsController < ApplicationController
  require 'csv'

  def index
    @costs = Cost.all
    @incomes = Income.all
    respond_to do |format|
      format.html
      format.csv do
        costs_to_csv
      end
    end
  end

  def costs_to_csv
    bom = "\uFEFF"
    csv_date = CSV.generate(bom) do |csv|
      csv_column_names = ["日付","支出内容","価格","説明"]
      csv << csv_column_names
      @costs.each do |cost|
        csv_column_values = [
          cost.date,
          cost.name,
          cost.price,
          cost.description,
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date, filename: "支出一覧.csv")
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

  def daily
    @daily = Cost.find(params[:date]).select("date(date) as costs_date, name as costs_name, price as costs_price").group("date(date)")
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
      params.require(:cost).permit(:name, :price, :description, :date)
    end
end

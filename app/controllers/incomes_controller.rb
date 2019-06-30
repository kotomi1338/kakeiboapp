class IncomesController < ApplicationController
  require 'csv'

  def index
    @incomes = Income.all
    @costs = Cost.all
    respond_to do |format|
      format.html
      format.csv do
        incomes_to_csv
      end
    end
  end

  def incomes_to_csv
    bom = "\uFEFF"
    csv_date = CSV.generate(bom) do |csv|
      csv_column_names = ["日付","支出内容","価格","説明"]
      csv << csv_column_names
      @incomes.each do |income|
        csv_column_values = [
          income.date,
          income.name,
          income.price,
          income.description,
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date, filename: "収入一覧.csv")
  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      redirect_to incomes_url, notice: "収入「#{@income.name}」を登録しました"
    else
      render :new
    end
  end

  def show
    @income = Income.find(params[:id])
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    income = Income.find(params[:id])
    income.update!(income_params)
    redirect_to incomes_url, notice: "収入「#{income.name}」を更新しました"
  end

  def destroy
    income = Income.find(params[:id])
    income.destroy
    redirect_to incomes_url, notice: "収入「#{income.name}」を削除しました。"
  end

  private

    def income_params
      params.require(:income).permit(:name, :price, :description, :date)
    end

end

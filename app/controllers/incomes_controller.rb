class IncomesController < ApplicationController
  def index
    @incomes = Income.all
    @costs = Cost.all
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

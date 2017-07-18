class TransactionsController < ApplicationController

  before_action :authenticate_user!
  before_action :modify_value_in_params, only: [:create, :update]

  def new
    @transaction=Transaction.new
  end

  def create
    @account = Account.find(current_user.id)
    @transaction = @account.transactions.build(transaction_params)

    if @transaction.valid?&&@account.update(money: @account.money+=@transaction.value)
      @transaction.save
      redirect_to transactions_path
    else
      show_flash_errors
      redirect_to new_transaction_path
    end
  end

  def edit
    @transaction=Transaction.find(params[:id])
    @transaction.value=(@transaction.value<0) ? (-@transaction.value) : (@transaction.value)
  end

  def update
    @account = Account.find(current_user.id)
    @transaction=Transaction.find(params[:id])

    if @transaction.valid?&&@account.update(money: @account.money+=params[:transaction][:value].to_f-@transaction.value)
      @transaction.update_attributes(transaction_params)
      redirect_to transactions_path
    else
      show_flash_errors
      redirect_to edit_transaction_path
    end

  end

  def index
    @account=Account.find(current_user.id)
    @transactions=@account.transactions.order('created_at DESC').paginate(page: params[:page], per_page: 9)
    @transactions_categories=get_name_of_categories
  end

  def destroy
    @account = Account.find(current_user.id)
    @transaction= Transaction.find(params[:id])
    @account.update(money: @account.money-=@transaction.value)
    @transaction.destroy

    redirect_to transactions_path
  end

  private

  def modify_value_in_params
    params[:transaction][:value]=-(params[:transaction][:value].to_f) unless ActiveModel::Type::Boolean.new.cast(params[:transaction][:direction])
  end

  def show_flash_errors
    flash[:danger] = @transaction.errors.to_a.join('. ')+@account.errors.to_a.join
  end

  def get_name_of_categories
    TransactionsCategoriesService.new(@transactions).get_name_of_categories_service
  end


  def transaction_params
    params.require(:transaction).permit(:description, :value, :direction, :category_id)
  end

end


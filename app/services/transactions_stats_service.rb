class TransactionsStatsService

  def initialize
  end

  def gets_transactions_stats_service
    create_stats_hash(get_category_transaction_count,
                      get_account_sum_stats,
                      get_transactions_count,
                      get_profitable_transactions,
                      get_losing_transactions,
                      get_totally_earned,
                      get_totally_spent)
  end


  private

  def get_category_transaction_count
    categories=Hash.new
    Category.all.each do |category|
      categories[category.kind]=Transaction.where(category_id: category.id).count
    end
    categories
  end

  def get_account_sum_stats
    sum=0
    Transaction.group_by_day(:created_at).sum('value').transform_values {|value| sum+=value}
  end

  def get_transactions_count
    Transaction.all.count
  end

  def get_profitable_transactions
    Transaction.where(direction: true).count
  end

  def get_losing_transactions
    Transaction.where(direction: false).count
  end

  def get_totally_earned
    Transaction.where(direction: true).sum('value')
  end

  def get_totally_spent
    Transaction.where(direction: false).sum('value')
  end

  def create_stats_hash(category_tr_count, acc_sum, tr_count, profit_tr, losing_tr, totally_earned, totally_spent)
    {
        category_tr_count: category_tr_count,
        acc_sum: acc_sum,
        tr_count: tr_count,
        profit_tr: profit_tr,
        losing_tr: losing_tr,
        totally_earned: totally_earned,
        totally_spent: totally_spent,
    }
  end

end
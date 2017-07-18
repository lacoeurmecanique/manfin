class CategoryStatsService

  def initialize(categories)
    @categories=categories
    @category_stats=Hash.new
  end

  def get_categories_stats_service
    @categories.each do |category|
      @category_stats[category.id]=create_hash(get_category_transactions(category.id),
                                               get_category_spent(category.id),
                                               get_category_earn(category.id),
                                               get_category_earn(category.id)-get_category_spent(category.id))
    end
    @category_stats
  end

  private

  def get_category_transactions (id)
    Transaction.where(category_id: id).count
  end

  def get_category_spent (id)
    Transaction.where(category_id: id, direction: false).sum('value')
  end

  def get_category_earn(id)
    Transaction.where(category_id: id, direction: true).sum('value')
  end

  def create_hash(transactions, spent, earned, summary)
    {
        transactions: transactions,
        spent: spent,
        earned: earned,
        summary: summary
    }
  end

end
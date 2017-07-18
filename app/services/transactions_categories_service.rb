class TransactionsCategoriesService

  def initialize(transactions)
    @transactions=transactions
  end

  def get_name_of_categories_service
    categories_names=Hash.new
    @transactions.each do |transaction|
      categories_names[transaction.id]=find_categories(transaction.category_id)
    end
    categories_names
  end

  private

  def find_categories(id)
    Category.find(id).kind
  end

end
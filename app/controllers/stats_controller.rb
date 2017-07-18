class StatsController < ApplicationController

  def index
    @transactions_stats=get_transactions_stats
  end

  private

  def get_transactions_stats
    TransactionsStatsService.new().gets_transactions_stats_service
  end
end

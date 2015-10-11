module ReportsHelper
	def agent_sum_trade(agent, date_range)
		Trade.published.select('sum(biz_count) biz_count, sum(amount) amount, sum(commission) commission, sum(actual_amount) actual_amount, sum(base_commission) base_commission, sum(profit) profit').where(merchant_number: agent.agent_merchants.map{|m| m.merchant_number}).where(trade_date: date_range).first
	end
end


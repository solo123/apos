class ReportsController < ApplicationController
	layout "no_layout", except: [:index]
	def monthly
		@results = Trade.all(
			:select => "trade_date, sum(biz_count) biz_count, sum(amount) amount, sum(profit) profit",
			:group => "strftime('%m', trade_date)",
			:conditions => {:status => 1},
			:order => 'trade_date desc')
	end
	def daily
		@start_date = Date.today.at_beginning_of_month
  	@end_date = Date.today.next_month.at_beginning_of_month - 1
		@start_date = params[:start_date].to_date if params[:start_date]
		@end_date = params[:end_date].to_date if params[:end_date]
		@results = Trade.all(
			:select => "trade_date, sum(biz_count) biz_count, sum(amount) amount, sum(profit) profit",
      :group => "strftime('%m-%d', trade_date)",
			:conditions => {status: 1, trade_date: @start_date..@end_date},
			:order => 'trade_date desc')
		@data_fields = %w'交易日期 交易笔数 交易金额 交易分润'
		@data_attrs  = %w'trade_date biz_count amount profit' 
		@data_class  = %w'mid num_i num_f num_f'
		render 'report_data.js'
	end
	def agents
		@start_date = Date.today.at_beginning_of_month
  	@end_date = Date.today.next_month.at_beginning_of_month - 1
		@start_date = params[:start_date].to_date if params[:start_date]
		@end_date = params[:end_date].to_date if params[:end_date]
	end
	def merchants
		@start_date = Date.today.at_beginning_of_month
  	@end_date = Date.today.next_month.at_beginning_of_month - 1
		@start_date = params[:start_date].to_date if params[:start_date]
		@end_date = params[:end_date].to_date if params[:end_date]
		@results = Trade.select("merchant_number, merchant_name,  sum(biz_count) biz_count, sum(amount) amnt, sum(profit) profit")
		  .where(status: 1).where(trade_date: @start_date..@end_date).group(:merchant_number).order('amnt desc')
	end
	def merchant
		@start_date = params[:start_date].to_date
  	@end_date = params[:end_date].to_date
		@results = Trade.all(
			:select => "trade_date, biz_count, amount, profit",
			:conditions => {status: 1, trade_date: @start_date..@end_date, merchant_number: params[:merchant]},
			:order => 'trade_date desc')
		@data_fields = %w'交易日期 交易笔数 交易金额 交易分润'
		@data_attrs  = %w'trade_date biz_count amount profit' 
		@data_class  = %w'mid num_i num_f num_f'
		r = Trade.where(merchant_number: params[:merchant]).last
		@report_title = "商户交易明细(商户号：#{r.merchant_number}，商户名称：#{r.merchant_name})"
		render 'report_data.js'
	end
end





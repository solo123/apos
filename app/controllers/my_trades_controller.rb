class MyTradesController < ApplicationController
  def index
		params[:q] ||= {}
		@q = Trade.search(params[:q])
		u = nil
		if current_user.admin?
			u = User.find(session[:mock_user]) if session[:mock_user]
		else
  		u = current_user
		end
		mer_numbers = []
		if u && u.agent?
			mer_numbers =  u.agent_merchants.map{|m| m.merchant_number}
    else
			mer_numbers = u.client_merchants.map{|m| m.merchant_number} if u
		end
		@data_user = u
    pages = 20
	  @collection = @q.result.where(merchant_number: mer_numbers).order('trade_date desc, id desc').paginate(:page => params[:page], :per_page => pages)
		@sum ||= @q.result.where(merchant_number: mer_numbers).select('sum(biz_count) biz_count, sum(amount) amount, sum(commission) commission, sum(actual_amount) actual_amount, sum(base_commission) base_commission, sum(profit) profit').first
  end
end


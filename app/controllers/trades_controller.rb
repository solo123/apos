class TradesController < ResourcesController
	before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end
  def import
    trade_date = params[:trade_date]
    data = params[:import_text]
    lines = data.split(/\n/)
    imp_lines = 0
    lines.each do |line|
      cs = line.split(/[\t]/)
      if cs.length>5 && cs[0].to_i > 0
        b = Trade.new
        b.trade_date = trade_date
        b.merchant_number = cs[0].strip
        b.merchant_name = cs[1]
        b.agent_number = ''
        b.agent_name = cs[2]
        b.merchant_tel = cs[3]
        b.rate = cs[4]
        b.terminal_number = ''
        b.biz_count = cs[5].to_i
        b.amount = cs[6].to_f
        b.status = 0
        imp_lines += 1
        b.save
      end
    end
    flash[:notice] = "导入#{imp_lines}行数据。"
  end
  def del
    Trade.destroy_all(status: 0)
  end
  def submit
=begin
    Trade.new_import.each do |t|
      Merchant.find_or_create_by(merchant_number: t.merchant_number) do |m|
        m.merchant_name = t.merchant_name
        m.status = 1
      end
    end
=end
    Trade.where(status: 0).update_all(status: 1)
  end
  def rm
    dt = params[:dt].to_date
    if dt
      Trade.where(trade_date: dt).destroy_all
    end
    redirect_to trades_path('q[trade_date_gteq]' => dt, 'q[trade_date_lteq]' => dt)
  end

  protected
    def load_collection
      params[:q] ||= {}
      if params[:op] == 'import'
        @q = Trade.new_import.search(params[:q])
      else
        @q = Trade.published.search(params[:q])
      end
      pages = 20
      @collection = @q.result.paginate(:page => params[:page], :per_page => pages)
			@sum ||= @q.result.select('sum(biz_count) biz_count, sum(amount) amount').first
    end 

  private
    def trade_params
      params.require(:trade).permit(:trade_date, :merchant_number, :merchant_name, :merchant_tel, :agent_number, :agnet_name, :terminal_number, :biz_count, :amount, :status)
    end
end

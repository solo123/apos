class UsersController < ResourcesController
	before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end

  def add
    params.permit!
    @object = User.new(params[:user])
    if @object.save
      redirect_to users_path
      return
    else
      flash[:error] = @object.errors.full_messages.to_sentence
      @no_log = 1
    end
    render :new
  end
  def add_agent_merchant
    @object = User.find(params[:id])
    @object.agent_merchants << Merchant.find(params[:merchant_id])
  end
  def del_agent_merchant
    @object = User.find(params[:id])
    m = Merchant.find(params[:merchant_id])
    m.agent = nil
    m.save
  end
	def mock
		session[:mock_user] = params[:id]
		redirect_to :controller => :my_trades, :action => :index
	end
end


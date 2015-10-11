class ClientsController < ApplicationController
  def index
		if current_user.admin? && session[:mock_user]
			@collection = User.find(session[:mock_user]).clients
		else
      @collection = current_user.clients
		end
  end
	def new
		@object = User.new
	end
	def create
		params.permit!
		@object = User.new(params[:user])
		if current_user.admin? && session[:mock_user]
			@object.agent = User.find(session[:mock_user])
		else
  		@object.agent = current_user
		end
		@object.roles = 'client'
		if @object.save
			redirect_to action: :index
			return
		end
		render action: :new
	end
	def edit
		@object = User.find(params[:id])
	end
	def update
		@object = User.find(params[:id])
		params.permit!
		@object.attributes = params[:user]
	  if @object.save
			redirect_to action: :index
		else
			flash[:error] = @object.errors.full_messages.to_sentence
		end
	end
  def add_merchant
    @object = User.find(params[:id])
    @object.client_merchants << Merchant.find(params[:merchant_id])
  end
  def del_merchant
    @object = User.find(params[:id])
    m = Merchant.find(params[:merchant_id])
    m.client = nil
    m.save
  end

  private
    def client_params
      params.require(:client).permit(:trade_date, :merchant_number, :merchant_name, :agent_number, :agnet_name, :terminal_number, :biz_count, :amount, :commission, :actual_amount, :base_commission, :profit, :status)
    end
end



class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :agent_merchants, foreign_key: 'agent_id', class_name: 'Merchant'
	has_many :client_merchants, :foreign_key => 'client_id', :class_name => 'Merchant'
	has_many :clients, foreign_key: 'agent_id', class_name: 'User'
	belongs_to :agent, :class_name => 'User'

	scope :all_agents, -> { where('roles like "%agent%"') }

	def admin?
		self.roles && self.roles.index('admin')
	end
	def agent?
		self.roles && self.roles.index('agent')
	end
end

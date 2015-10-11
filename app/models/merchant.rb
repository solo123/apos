class Merchant < ActiveRecord::Base
	belongs_to :agent, :class_name => 'User'
	belongs_to :client, :class_name => 'User'
  
  scope :free_merchants, -> { where(agent_id: nil) } 
	scope :free_client_merchants, -> { where(client_id: nil) }
end

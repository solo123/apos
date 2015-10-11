class Trade < ActiveRecord::Base
  scope :new_import, -> { where(status: 0) }
  scope :published, -> { where(status: 1) }
end

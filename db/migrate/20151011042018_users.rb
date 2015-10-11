class Users < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :username, default: ""
      t.string :mobile, default: ''
      t.string :roles, default: ''
      t.timestamps
    end
  end
end

class AddColumnCanAvailTrialToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :can_avail_trial, :boolean,default: true
  end
end

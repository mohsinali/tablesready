ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do

    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :restaurant
    column :country
    column :trial_ends_at
    column :trial_extended
    column :walkin_status
    column :marketing_status
    column :created_at
    actions do |user|
      link_to 'Extend Trial', extend_trial_admin_user_path(user),method: :put,title: "Extend Trial for #{ENV['TRIAL_EXTENDABLE_DAYS']} days"
    end
  end

  member_action :extend_trial, method: :put do
    user = User.find_by(id: params[:id])
    subscription = user.subscriptions.last
    user.update(trial_extended: true,trial_ends_at: user.trial_ends_at + ENV['TRIAL_EXTENDABLE_DAYS'].to_i.days)
    subscription.update(expired_at: user.trial_ends_at) if subscription
    redirect_to admin_users_path,notice: "User's trial extended until #{user.trial_ends_at.to_date}"
  end


end

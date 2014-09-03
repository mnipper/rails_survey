ActiveAdmin.register AdminUser do
  menu priority: 2
  permit_params :email, :password, :password_confirmation, :gauth_enabled

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :gauth_enabled, :as => :radio
    end
    f.actions
  end

end

ActiveAdmin.register User do
  menu priority: 3
  
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  show do |user|
    attributes_table do
      row :id
      row :email
      row 'Roles' do
        user.roles .each do |role|
          li {role.name}
        end
      end
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row "User Projects" do
        ul do
          user.projects.each do |project|
            li {project.name}
          end
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password, hint: "Leave blank. Do not change."
      f.input :password_confirmation
      unless current_page?(new_admin_user_path)
        f.input :projects, :as => :check_boxes
        f.input :roles, :as => :check_boxes
      end 
    end
    f.actions
  end

  controller do
    def update
      @user = User.find(params[:id])
      if params[:user].blank? || params[:password].blank? || params[:password_confirmation].blank?
        @user.update_without_password(params[:user])
      else
        @user.update_attributes(params[:user])
      end
      if @user.errors.blank?
        redirect_to admin_user_path(params[:id]), :notice => "User updated successfully."
      else
        render :edit
      end
    end
  end
  
end

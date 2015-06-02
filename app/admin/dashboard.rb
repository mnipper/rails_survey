ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        if current_admin_user.gauth_enabled == "f"
          panel "Warning" do
            para "You currently do not have two factor authentication enabled.  Please enable it!"
            para link_to "Set up Two Factor Authentication", admin_user_displayqr_path
          end
        end
      end
    end
  end 
  
end
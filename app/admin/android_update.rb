ActiveAdmin.register AndroidUpdate do
  permit_params :version, :apk_update

  form do |f|
    f.inputs "Android APK Details" do
      f.input :version
      f.input :apk_update, :as => :file
    end
    f.actions
  end
 
end
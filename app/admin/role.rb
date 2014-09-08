ActiveAdmin.register Role do
  
  show do |role|
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
      row 'Users' do
        role.users .each do |user|
          li {user.email}
        end
      end
     active_admin_comments
    end
  end
end

# ActiveAdmin.register Role do
# 
  # index do |role|
    # column :name
    # column :created_at
    # column :updated_at
    # column 'Number of Users' do |number|
      # Role.where('name = ? AND user_id != ?', number.name, '').count 
    # end
# 
    # default_actions
  # end
# 
  # filter :name
# 
  # show do |role|
    # attributes_table do
      # row :id
      # row :name
      # row :created_at
      # row :updated_at
      # row 'Users with role' do
        # ul do
          # Role.where('name' => role.name).each do |user|
            # li{user.user_id}
          # end
        # end
      # end
    # end
  # end
# end
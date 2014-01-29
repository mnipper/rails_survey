ActiveAdmin.register Role do

  index do
    column :name
    column :created_at
    column :updated_at
    column 'Number of Users' do |number|
      number.users.count
    end

    default_actions
  end

  filter :name

  show do |role|
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
      row 'Users with role' do
        ul do
          role.users.each do |user|
            li {user.email}
          end
        end
      end
    end
  end
end
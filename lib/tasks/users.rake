namespace :users do
  desc "Populate test user admin"
  task populate_admin: :environment do
    admin_role = Role.find_by(name: "Admin")
    users = [{ email: "test-user-admin@andela.com",
               id: "-KesEogCwjq6lkOzKmLI", first_name: "Test",
               last_name: "Admin", andela: {} }]
    users.each do |user|
      User.create(id: user[:id], first_name: user[:first_name],
                  last_name: user[:last_name], andela: user[:andela],
                  email: user[:email], role: admin_role)
    end
    Rails.logger.info "Admin user added successfully"
  end
end

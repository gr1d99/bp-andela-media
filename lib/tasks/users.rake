namespace :users do
  desc "Populate test user admin"
  task populate_admin: :environment do
    admin_role = Role.find_by(role: "Admin")
    users = [{ email: "test-user-admin@andela.com",
               camper_id: "-KesEogCwjq6lkOzKmLI" }]
    users.each do |user|
      User.create(camper_id: user[:camper_id],
                  email: user[:email], role: admin_role)
    end
    puts "Admin user added successfully"
  end
end

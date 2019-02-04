namespace :roles do
  desc "Populate roles"
  task populate_roles: :environment do
    roles = %w(Admin Fellow)
    roles.each do |role|
      Role.create(name: role)
    end
    Rails.logger.info "Roles added successfully"
  end
end
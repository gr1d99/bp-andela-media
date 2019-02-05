require "rails_helper"
require "rake"

describe "user.rake" do
  let!(:role) { create :role, name: "Admin" }

  before :all do
    Rake.application.rake_require "tasks/db"
    Rake::Task.define_task(:environment)
  end

  let(:run_rake_task) do
    Rake::Task["db:populate_admin"].reenable
    Rake.application.invoke_task "db:populate_admin"
  end

  context "when this task is invoked" do
    it "the database is populated with an admin user" do
      run_rake_task
      expect(User.find_by(email: "test-user-admin@andela.com")).to be_truthy
    end
  end
end

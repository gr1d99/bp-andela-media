require "rails_helper"
require "rake"

describe "roles.rake" do
  before :all do
    Rake.application.rake_require "tasks/roles"
    Rake::Task.define_task(:environment)
  end

  let(:run_rake_task) do
    Rake::Task["roles:populate_roles"].reenable
    Rake.application.invoke_task "roles:populate_roles"
  end

  context "when this task is invoked" do
    it "the database is populated with an admin user" do
      run_rake_task
      expect(Role.find_by(name: %w[Admin Fellow])).to be_truthy
    end
  end
end

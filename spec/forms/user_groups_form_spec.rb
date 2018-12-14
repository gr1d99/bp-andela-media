require "rails_helper"
require "faker"

RSpec.describe UserGroupForm, type: :form do
  before(:each) do
    @model = UserGroup.new
    @form = UserGroupForm.new(@model)
  end

  it "should require name" do
    @form.validate({})
    expect(@form.errors[:name]).to include("can't be blank")
  end

  it "should be valid if name is passed in" do
    @form.validate(name: "Cohort 0")
    @form.save
    expect(@form.model[:name]).to eq("Cohort 0")
  end

  it "should require name to be unique" do
    @form.validate(name: "Cohort 0")
    @form.save

    @model = UserGroup.new
    @form = UserGroupForm.new(@model)

    @form.validate(name: "Cohort 0")
    expect(@form.errors[:name]).to include("has already been taken")
  end
end

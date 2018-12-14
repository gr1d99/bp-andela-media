class UserGroupsController < ApplicationController
  def create
    @form = UserGroupForm.new(UserGroup.new)

    if @form.validate(user_group_params)
      @form.save
      render_response(@form.model, :created)
    else
      render_response(@form.errors, :bad_request)
    end
  end

  private

  def user_group_params
    params.require(:user_group).permit(:name, emails: [])
  end
end

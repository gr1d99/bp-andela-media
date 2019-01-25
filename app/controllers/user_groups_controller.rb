class UserGroupsController < ApplicationController
  before_action :set_user_group, only: %i[show update destroy]
  before_action :authenticate, only: %i[create update destroy]

  def create
    @form = UserGroupForm.new(UserGroup.new)

    if @form.validate(user_group_params)
      @form.save
      render_response(@form.model, :created)
    else
      render_response(@form.errors, :bad_request)
    end
  end

  def update
    if @user_group.present?
      if @user_group.update(user_group_params)
        render_response(@user_group, :ok)
      else
        render_response(@user_group.errors.messages, :unprocessable_entity)
      end
    else
      head :not_found
    end
  end

  def index
    @user_groups = UserGroup.all
    render_response(@user_groups, :ok)
  end

  def show
    if @user_group
      render_response(@user_group, :ok)
    else
      head :not_found
    end
  end

  def destroy
    if @user_group.present?
      @user_group.destroy
      head :ok
    else
      head :not_found
    end
  end

  private

  def user_group_params
    params.require(:user_group).permit(:name, emails: [])
  end

  def set_user_group
    @user_group = UserGroup.find_by(id: params[:id])
  end
end

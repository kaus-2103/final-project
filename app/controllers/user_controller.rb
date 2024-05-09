class UserController < ApplicationController
  def manager
    @user = User.all
  end

  def block_multiple
    selected_user_ids = params[:selected_user_ids]
    User.where(id: selected_user_ids).update_all(status: true)
    redirect_to user_manager_path, notice: 'Selected users blocked successfully.'
  end
  def block
    @user = User.find(params[:id])
    if @user.update(status: false)
      redirect_to user_manager_path, notice: 'User blocked successfully.'
    else
      redirect_to user_manager_path, alert: 'Failed to block user.'
    end 
  end

  def unblock
    @user = User.find(params[:id])
    if @user.update(status: true)
      redirect_to user_manager_path, notice: 'User blocked successfully.'
    else
      redirect_to user_manager_path, alert: 'Failed to block user.'
    end 
  end

  def add_admin
    @user = User.find(params[:id])
    if @user.update(admin: true)
      redirect_to user_manager_path, notice: 'User Promoted successfully.'
    else
      redirect_to user_manager_path, alert: 'Failed to block user.'
    end 
  end

  def remove_admin
    @user = User.find(params[:id])
    if @user.update(admin: false)
      redirect_to user_manager_path, notice: 'User Demoted successfully.'
    else
      redirect_to user_manager_path, alert: 'Failed to block user.'
    end 
  end

  def destroy
    @user.destroy
    redirect_to user_manager_path, notice: 'User deleted successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

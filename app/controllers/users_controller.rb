class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    render 'registrations/edit'
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render 'registrations/edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Profile created'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render 'registrations/new'
    end
  end


  private

  def user_params
    require(:user).permit(:first_name,
      :last_name,
      :email,
      :password
    )
  end
end

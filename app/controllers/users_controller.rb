class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(
    uid: params[:user][:uid],
    password: params[:user][:password],
    password_confirmation: params[:user][:password_confirmation])
    if @user.valid? #validatesを実行してくれる
      #TODO:成功したことを
      @user.pass = BCrypt::Password.create(params[:user][:password])
      @user.save
      flash[:notice] = '新規登録しました'
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = '登録情報を削除しました'
    redirect_to users_path
  end
end

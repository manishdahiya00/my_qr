class Admin::LoginController < ApplicationController
  def new
  end

  def login
    if params[:username] == "admin@gmail.com" && params[:password] == "123"
      session[:admin_authenticated] = true
      redirect_to admin_device_details_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def logout
    session[:admin_authenticated] = nil
    redirect_to admin_path, notice: "Logged out successfully!"
  end
end

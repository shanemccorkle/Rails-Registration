class RegistrationController < ApplicationController
  def register

  end

  def register_user
    if params.has_key?(:username) && !params[:username].strip.empty?
      # TODO: check for duplicate username
      user1 = User.new
      user1.firstname = params[:firstname]
      user1.lastname = params[:lastname]
      user1.username = params[:username]
      user1.password = params[:password]
      user1.save
      add_phone(user1, params[:phone1])
      add_phone(user1, params[:phone2])
      add_phone(user1, params[:phone3])
      cookies[:userid] = user1.id
      redirect_to '/registration/user_info'
    else
      render '/registration/register'
    end
  end

  def add_phone(user, phonenumber)
    phone1 = Phone.new
    if !phonenumber.empty?
      phone1.phonenumber = phonenumber
    else
      phone1.phonenumber = "No Phone"
    end
    user.phones << phone1
  end

  def user_info
    if !cookies[:userid].nil?
      @user = User.find(cookies[:userid])
    end
  end
end

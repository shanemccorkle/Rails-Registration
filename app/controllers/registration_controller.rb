class RegistrationController < ApplicationController
  def register

  end

  def register_user
    # check there is username data passing from the browser and it is not empty
    if params.has_key?(:username) && !params[:username].strip.empty?
      # check duplicate username. if user found in user table, it will go to else statement
      user = User.find_by_username(params[:username])
      # no user exist and password data passes the validation
      if user.nil? && validatePassword(params[:password])
        user1 = User.new
        # add user input to user1 variable (leave the fill empty if there is no data passes from browser. this will insert NULL value in SQL database)
        user1.firstname = params[:firstname] unless params[:firstname].empty?
        user1.lastname = params[:lastname] unless params[:lastname].empty?
        user1.streetaddr = params[:streetaddr] unless params[:streetaddr].empty?
        user1.city = params[:city] unless params[:city].empty?
        user1.state = params[:state] unless params[:state].empty?
        user1.zipcode = params[:zipcode] unless params[:zipcode].empty?
        user1.country = params[:country] unless params[:country].empty?
        user1.username = params[:username]
        user1.password = params[:password]
        user1.save
        # add phone to user
        add_phone(user1, params[:phone1])
        add_phone(user1, params[:phone2])
        add_phone(user1, params[:phone3])
        # save userid to cookies for tracking user session
        cookies[:userid] = user1.id
        redirect_to '/registration/user_info'
      else
        # found username is user table, send error message
        if !user.nil?
          flash.now[:notice] = "User ID taken, try another."
        end
        render '/registration/register'
      end
    else
      # stay on the same page if no username input
        render '/registration/register'
    end
  end

  # add phone to user table by checking if there is a phone number as a parameter. If not, it saves "No Phone" in the db.
  def add_phone(user, phonenumber)
    phone1 = Phone.new
    !phonenumber.empty? ? phone1.phonenumber = phonenumber : phone1.phonenumber = "No Phone"
    # add phone to user
    user.phones << phone1
  end

  def user_info
    # get user record using userid from cookies
    if !cookies[:userid].nil?
      @user = User.find(cookies[:userid])
    else
      flash[:notice] = "Please Log In to view User Info"
      redirect_to '/registration/login'
    end
  end

  def login
  end

  def login_user
    # check if there are username and password data passing from browser and they are not empty
    if params.has_key?(:username) && !params[:username].strip.empty? && params.has_key?(:password) && !params[:password].strip.empty?
      # search username (it is unique) in user table
      user = User.find_by_username(params[:username].strip)
      # if no user found
      if user.nil?
        flash[:alert] = "Log in failed, try again; Wrong Username"
        render 'login'
        flash[:alert] = ""
      else
        # if user found, check for password to match with password data from browser
        if user.password == params[:password]
          cookies[:userid] = user.id
          redirect_to '/registration/user_info'
        else
          # password not matched
          flash[:alert] = "Log in failed, try again; Wrong Password"
          render 'login'
          flash[:alert] = ""
        end
      end
    end
  end

  def logout
    # delete cookies
    cookies.delete :userid
    flash[:notice] = "You are now logged out"
    redirect_to '/registration/login'
  end

  # main method to check password and username
  def validatePassword(password)
    if check6char(password) || !pswdDoesNotContainSpecial(password) || pswdContainPswd(password)
      return false
    else
      return true
    end
  end

  # method that checks if the password are more than 6 characters
  def check6char(str)
    if str.length < 6
      flash[:alert] =  "Password must have more than 6 characters"
      true
    end
  end

  # checks the password for special characters. returns true if they are present
  def pswdDoesNotContainSpecial(str)
    a = (str =~ /[!#$]/)
    if a.to_i > 0
      true
    else
      flash[:alert] = "Password must contain at least one $, !, or #."
      false
    end
  end

  def pswdContainPswd(str)
    if str.upcase.include? "PASSWORD"
      flash[:alert] = "Password can not contain password!"
      true
    else
      false
    end
  end
end

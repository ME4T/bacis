class UsersController < ApplicationController
  

  def show
    @user = User.find(params[:id])
    if @user != nil
      
      @friends = @user.friends
      @transactions = @user.transactions.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def lends
     @title = "Lends"
     @date = params[:date] ? Date.parse(params[:date]) : Date.today
     @user = User.find(params[:id])
     @friends = @user.friends.paginate(page: params[:page])
     @transactions = User.find(params[:id]).transactions.where(:t_type => 2).paginate(page: params[:page], per_page: 5)
     render 'lends'
  end
  
  def borrows
     @title = "Borrows"
     @user = User.find(params[:id])
     @friends = @user.friends.paginate(page: params[:page])
      @transactions = User.find(params[:id]).transactions.where(:t_type => 1).paginate(page: params[:page], per_page: 5)
     render 'borrows'
  end
  def edit 
    @user=User.find(params[:id])
  end
  def update 
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def email_exists
    @user = User.where("email = ?", params[:email]).first
    valid = false
    if(@user)
      valid = false
    else
      valid = true
    end

    respond_to do |format|
      format.json { render json: "{\"valid\" : " + valid.to_s + "}" }
    end

  end

  def username_exists

    @user = User.where("username = ?", params[:username]).first


    valid = false
    if(@user)
      valid = false
    else
      valid = true
    end
    respond_to do |format|
      format.json { render json: "{\"valid\" : " + valid.to_s + "}" }
    end
  end
  
end
  

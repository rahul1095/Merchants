class Api::V1::RegisterUserController < ApplicationController
	before_action :authenticate_user! , except: [:login]
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

# 1.create new user
def create_user
  @user = User.new(register_user_params)
  @user.save!
  if @user.valid?
      sign_in("user", @user)
    end
   render status: 200, json: {Result: :success, message: "create succesfully",user: @user}
end

# 2.login by user
 def login
    email = params[:email] if params[:email]
   	password = params[:password] if params[:password]
   	# id= user.find_by(email: email).try(:id).presence?
   if email.nil? && password.nil?
   	 render status: 400, json: { success: false,message: "request must contain email and password"}
   end
    @user = User.find_by(email: email)

    if @user
    if @user.valid_password? password 	
     sign_in("user", @user)
     render status: 200, json: {Result: :success, message: "Successfully login",user: @user}
    else
     render status: 401, json: {Result: :false, message: "Invalid email and password"}
    end
   else
     render status: 401, json: { success:false, message: "Invalid email and password"}
   end	
 end

# 3. DESTROY User
def destroy
  @user =User.find_by(id: params[:id])
   if @user.nil?
     render status: 401, json: {Result: :false, message: "Invalid tocken"}
   else
      sign_out(@user)
      render status: 200, json: { success: true }
    end
end

#4. show all merchants
  def index
    @merchants = Merchant.all
    render status: 200, json: {Result: :success, message: "Successfully login",user: @merchants}
  end
#5. shoew particular merchants
def show
  @merchant =Merchant.find(params[:id])
 render status: 200, json: {Result: :success,user: @merchant}
end

#5. shoew all merchants
def destroy
 @merchant =Merchant.find(params[:id])
 @merchant.destroy
render status: 200, json: {Result: :success, message: "user delete successfully"}
 end 

# 6 create new merchants
def create
  @name= params[:name]
  @user_id= params[:user_id]
    @merchant = Merchant.new(name:@name, user_id:params[:user_id] )
   @merchant.save
   render status: 200, json: {Result: :success, message: "merchant craete succesfully",merchants: @merchant}
  end

# 7 edit  particular marchants

def edit
  @merchant =Merchant.find(params[:id])
  end

# 8 update particular merchant
def update
   @merchant =Merchant.find(params[:id])
    @name= params[:name]
   @user_id= params[:user_id]
   @merchant = @merchant.update(name:@name, user_id:params[:user_id] )
   render status: 200, json: {Result: :success, message: "merchant update succesfully",merchants: @merchant}
  end

 private
 def merchant_params
      params.require(:merchant).permit( :name,:user_id)
    end

end

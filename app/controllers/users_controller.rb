class UsersController < ApplicationController
  # POST
  def auth_code
    tel = params['telephone']
    user = User.new(telephone: tel)
    if user.valid?
      #fake
      code = tel[-4.. -1]
      if user.update_auth_code(code)
        render json: [0, 'send success.']
      else
        render json: [1, 'please wait']
      end

    else
      render json: [2, user.errors.full_messages.join("\r\n")]
    end
  end

  # GET
  def new
    @user = User.new
  end

  # POST
  def create
    @user = User.new(user_create_params)

    if @user.check_auth_code && @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:telephone, :password, :auth_code)
  end
end

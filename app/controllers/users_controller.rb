class UsersController < ApplicationController
  # POST
  def auth_code
    tel = params['telephone']
    is_login = params['is_login_form'] == 'true'
    
    if is_login
      # 手机号登录

      user = User.find_by(telephone: tel)
      if user
        #fake
        code = tel[-4.. -1]
        if user.update_auth_code(code)
          render json: [0, 'send success.']
        else
          render json: [1, 'please wait']
        end

      else
        render json: [2, 'telephone not found']
      end

    else
      # 手机号注册

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
  end

  # GET
  def new
    @user = User.new
  end

  # POST
  def create
    @user = User.new(user_create_params)

    if @user.check_auth_code && @user.save
      log_in @user
      remember @user
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

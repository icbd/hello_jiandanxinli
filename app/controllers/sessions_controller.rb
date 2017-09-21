class SessionsController < ApplicationController
  # GET
  # /login
  def new
  end

  # POST
  def create
    tel = params[:session][:telephone]
    pswd = params[:session][:password]
    code = params[:session][:auth_code]

    user = User.find_by(telephone: tel)

    if user
      if !code.empty?
        # 验证码登录
        user.auth_code = code
        if user.check_auth_code
          log_in user
          remember user
          flash.now[:success] = 'login success'
          redirect_to root_url
        else
          flash.now[:danger] = 'wrong auth code'
          render :new
        end


      else
        # 密码登录
        if hash_authed?(pswd, user.password_digest)
          log_in user
          remember user
          flash.now[:success] = 'login success'
          redirect_to root_url
        else
          flash.now[:danger] = 'wrong password'
          render :new
        end

      end

    else
      flash.now[:danger] = 'telephone not found'
      render :new
    end
  end

  # DELETE
  # /logout
  def destroy
    log_out
    redirect_to root_url
  end

end

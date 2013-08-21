# -*- coding: utf-8 -*-
class Users::RegistrationsController < Devise::RegistrationsController
  layout "default", except: [:edit, :update]

  #  POST /users
  def create
    build_resource(params[:user])

    if request.post? && captcha_valid?(params[:captcha])
      super
    else
      resource.errors.add(:captcha, '验证码错误')
      render 'new'
    end
  end

  protected
  def after_sign_up_path_for(resource)
    welcome_users_path
  end
end

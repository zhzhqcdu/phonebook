# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Sessions < Grape::API
    use Rack::JSONP
    format :json

    get "/login" do


      #      resource = User.find_for_database_authentication(:email => params[:account])
      #      if resource.valid_password?(params[:password])
      #        Devise.sign_in(:user, resource)
      #        resource.ensure_authentication_token!
      #        return {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
      #      end
    end


  end
end

=begin
    def login
      resource = User.find_for_database_authentication(:email => params[:account])
      if resource.valid_password?(params[:password])
        sign_in(:user, resource)
        resource.ensure_authentication_token!
        return {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
      end
    end

    def logout
      resource = User.find_for_database_authentication(:email => params[:email])
      if resource && resource.update_attribute(:authentication_token, nil)
        return {:status => 'success', :message => '退出成功'}
      end
    end

    def get_user
      result = User.where(email: params[:email],authentication_token: params[:token])
      return result.first
    end
  end
end
=end

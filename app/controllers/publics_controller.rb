# -*- coding: utf-8 -*-
class PublicsController < ApplicationController
  def index
    @organs = Organ.roots
  end

  def login
    @user = User.new
    render layout: false
  end

  def authenticate
    @user = User.login(params[:user])
    if @user.present?
      if params[:remember] == "true"
        cookies[:remember] = {:value => @user.generate_authentication_token, :expires => System.login_remember_days}
      end

      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path, :alert => '账号或密码错误'
    end
  end

  def logout
    current_user.update_attribute(:authentication_token, nil)
    session.clear
    redirect_to root_path, :notice => '退出成功'
  end

  def search
    @value = params[:value]
    @organs = SearchEngine.search_organs(@value)
    @users = SearchEngine.search_users(@value, current_user.visible_leader).paginate(:per_page => System.page_num, :page => params[:page])

    if (@organs.size == 1) and (@users.blank?)
      @organ = @organs.first
      @value = @organ.fullname

      if Settings.order_by_job
        @members = load_members = @organ.members.joins { jobs }.order("jobs.sort DESC").paginate(:per_page => System.page_num, :page => params[:page])
        @users = User.joins { members }.where { members.id.in load_members }
                     .sort { |x, y| y.members.map { |e| e.jobs.map(&:sort).max }.max <=> x.members.map { |e| e.jobs.map(&:sort).max }.max }
      else
        organ, visible_leader = @organ, current_user.visible_leader
        @users = User.joins { members.organ }.where { (members.organ.id == organ.id) & (members.organ.is_leader == visible_leader) }.order("sort DESC").paginate(:per_page => System.page_num, :page => params[:page])
      end
    elsif (@organs.blank?) and (@users.size == 1)
      @user = @users.first
      return render "result_user"
    end
    render "result"
  end
end

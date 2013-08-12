# -*- coding: utf-8 -*-
require 'spec_helper'

describe UserApply do
  describe '未加入组织用户' do
    before :each do
      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors
      @admin_membership = Membership.where( :name => build(:admin).name ).first
      @member_membership = Membership.where( :name => build(:member).name ).first

      @behind_user_one = create :behind_user_one
    end

    it '申请加入某个组织, 应该申请成功' do
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_true
    end

    it '已申请加入组织，正在审核时，再次申请同一组织，应该申请失败' do
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_true
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_false
    end

    it '再次申请非同一顶级组织的其它组织，应该申请失败' do
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_true
      UserApply.safe_add( :user => @behind_user_one, :organ => create(:system_organ), :membership => @member_membership ).should_not be_true
    end
  end

  describe '已加入企业用户' do
    before :each do
      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors
      @admin_membership = Membership.where( :name => build(:admin).name ).first
      @member_membership = Membership.where( :name => build(:member).name ).first

      @behind_user_one = create :behind_user_one
      @zhiyi_software_behind.actors.each { |e| e.users << @behind_user_one }      
    end

    it '再次申请同一组织，应该申请失败' do
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_false
    end

    it '再次申请非同一顶级组织的其它组织，应该申请失败' do
      expect( UserApply.safe_add( :user => @behind_user_one, :organ => create(:system_organ), :membership => @member_membership ) ).to be_false
    end
  end

  describe 'Callback 测试' do
    before :each do
      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors
      @admin_membership = Membership.where( :name => build(:admin).name ).first
      @member_membership = Membership.where( :name => build(:member).name ).first

      @behind_user_one = create :behind_user_one

      expect( UserApply.safe_add( :user => @behind_user_one, :organ => @zhiyi_software_behind, :membership => @member_membership ) ).to be_true
    end

    it '审核通过后，自动添加记录到 actors_users 中，并从 applies 中删除记录' do
      expect( @behind_user_one.actors ).to be_empty
      expect( UserApply.all.size ).to eq 1
      
      UserApply.last.pass.should be_true
      
      expect( User.find(@behind_user_one.id).actors.size ).to eq 1
      expect( UserApply.all ).to be_empty
    end
  end
end

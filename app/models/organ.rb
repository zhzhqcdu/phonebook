# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :rank_id, :address, :description, :postalcode, :areacode, :status, :parent_id

  validates_presence_of :name, :rank_id

  belongs_to :rank

  has_many :actors
  has_ancestry

  def add_admin user
    ActorUser.new( user: user, actor: Actor.find_or_new_organ_admin(self) ).save
  end

  def add_member user
    ActorUser.new( user: user, actor: Actor.find_or_new_organ_member(self) ).save
  end

  def add_member_and_admin user
    add_admin(user) && add_member(user)
  end
end

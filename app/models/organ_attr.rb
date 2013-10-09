# -*- coding: utf-8 -*-
class OrganAttr < ActiveRecord::Base
  attr_accessible :key, :value, :organ_id
  validates_presence_of  :key, :value, :organ_id

  belongs_to :organ
end
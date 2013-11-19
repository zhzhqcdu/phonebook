# -*- coding: utf-8 -*-
class SearchEngine
  class << self

    def search_organs value
      return [] if value.blank?
      organ = Organ.search_by_fullname(value)

      value = value.downcase.split('').join("%").insert(0, "%").insert(-1, "%")

      ([organ] + Organ.where{ (name.like value) | (pinyin.like value) }).uniq.compact
    end

    def search_users value
      return [] if value.blank?
      value = value.downcase.split('').join("%").insert(0, "%").insert(-1, "%")

      User.where{ (name.like value) | (pinyin.like value) | (mobile_phone.like value) }      
    end

  end
end
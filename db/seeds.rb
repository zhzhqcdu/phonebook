# -*- coding: utf-8 -*-

=begin
# 系统初始化 权限组
manage_system = Permission.create!(name: '系统管理', code: 'master',level: 0)
manage_organ = Permission.create!(name: '管理所属企业', code: 'master_organ', level: 1)
read_organ = Permission.create!(name: '查看所属企业', code: 'read_organ', level: 1)
=end
# # 系统初始化 系统管理员=企业管理员
# organ  = Organ.create!(name: "知一软件" )

# admin = Membership.create!(name: "系统管理员")
# member = Membership.create!(name: "成员")

# system_actor = Actor.create!(organ_id: organ.id, membership_id: admin.id)

# # 将 系统管理组/超级管理员 加入 超级管理员权限组
# system_actor.users << User.create!(name:"谢刚", email:"tianbymy@163.com", password:"123456", phone: "18628171676")

User.create!(name:"谢刚", username: "tianbymy", password:"123456", phone: "18628171676")
User.create!(name:"唐久军", username: "tangjiujun", password:"tang", phone: "18782943143")
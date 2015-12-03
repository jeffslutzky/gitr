# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  uid        :integer
#  provider   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

	has_one :admin
	has_one :collaborator
	validates :name, presence: true

	def self.create_from_omniauth(auth_hash)
	  self.create(provider: auth_hash[:provider],
	              uid: auth_hash[:uid],
	              name: auth_hash[:info][:name])

	end


end

# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Collaborator, type: :model do
	let(:collaborator) {FactoryGirl.build(:collaborator, user: user)}

	
end

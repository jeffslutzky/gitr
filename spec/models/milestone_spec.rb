# == Schema Information
#
# Table name: milestones
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  state       :string
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Milestone, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

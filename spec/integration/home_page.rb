require 'spec_helper'

describe 'visiting the home page' do
  it 'welcomes the user' do
    visit "/"
    expect(page).to have_content('Users Index')
  end
end

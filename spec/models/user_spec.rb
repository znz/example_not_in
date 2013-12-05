require 'spec_helper'

describe User do
  it do
    expect(FactoryGirl.create(:user)).to be_a User
  end
end

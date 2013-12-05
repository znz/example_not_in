require 'spec_helper'

describe Post do
  it do
    expect(FactoryGirl.create(:post)).to be_a Post
  end
end

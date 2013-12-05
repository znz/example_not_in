require 'spec_helper'

describe Post do
  it do
    expect(FactoryGirl.create(:post)).to be_a Post
  end

  context "with 2 posts" do
    before do
      2.times do
        FactoryGirl.create(:post)
      end
    end
    let(:user) { FactoryGirl.create(:user) }

    it { expect(Post.count).to eq(2) }

    it "no voted posts" do
     expect(Post.search(votes_voter_id_in: user.id).result(distinct: true).count).to eq(0)
    end
    it "two unvoted posts" do
     expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(2)
    end
    context "with one voted post" do
      before { user.vote_for(Post.first) }

      it "one voted post" do
        expect(Post.search(votes_voter_id_in: user.id).result(distinct: true).count).to eq(1)
      end
      it "one unvoted post" do
        expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(1)
      end
    end
  end
end

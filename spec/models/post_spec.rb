require 'spec_helper'

describe Post do
  it do
    expect(FactoryGirl.create(:post)).to be_a Post
  end

  context "with 15 posts" do
    before do
      users = 15.times.map { FactoryGirl.create(:user) }
      15.times do
        post = FactoryGirl.create(:post)
        users.each { |u| u.vote_for(post) }
      end
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }

    def voted_by(user_id)
      Post.search(votes_voter_id_in: user_id).result(distinct: true)
    end

    def not_voted_by(user_id)
      post_at = Post.arel_table
      post_id = post_at[:id]
      scope = Post.includes(:votes).references(:votes)
      arel = scope.where(post_id.not_in(voted_by(user_id).select(post_id).arel))
      #puts arel.to_sql
      arel
    end

    it { expect(Post.count).to eq(15) }

    it "no voted posts" do
      expect(voted_by(user.id).count).to eq(0)
    end
    it "15 not_voted posts" do
      expect(not_voted_by(user.id).count).to eq(15)
    end

    context "with posts voted by another_user" do
      before do
        Post.all.each do |post|
          another_user.vote_for(post)
        end
      end
      context "user" do
        it "no voted posts" do
          expect(voted_by(user.id).count).to eq(0)
        end
        it "15 not_voted posts" do
          expect(not_voted_by(user.id).count).to eq(15)
        end
      end
      context "another_user" do
        it "15 voted posts" do
          expect(voted_by(another_user.id).count).to eq(15)
        end
        it "no not_voted posts" do
          expect(not_voted_by(another_user.id).count).to eq(0)
        end
      end
    end

    context "with posts voted by both" do
      before do
        Post.all.each do |post|
          user.vote_for(post)
          another_user.vote_for(post)
        end
      end
      context "user" do
        it "15 voted posts" do
          expect(voted_by(user.id).count).to eq(15)
        end
        it "0 not_voted posts" do
          expect(not_voted_by(user.id).count).to eq(0)
        end
      end
      context "another_user" do
        it "15 voted posts" do
          expect(voted_by(another_user.id).count).to eq(15)
        end
        it "no not_voted posts" do
          expect(not_voted_by(another_user.id).count).to eq(0)
        end
      end
    end
  end
end

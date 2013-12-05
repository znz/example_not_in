require 'spec_helper'

describe Post do
  it do
    expect(FactoryGirl.create(:post)).to be_a Post
  end

  context "with 15 posts" do
    before do
      15.times do
        FactoryGirl.create(:post)
      end
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }

    it { expect(Post.count).to eq(15) }

    it "no voted posts" do
     expect(Post.search(votes_voter_id_in: user.id).result(distinct: true).count).to eq(0)
    end
    pending "15 unvoted posts" do
     expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(15)
    end
    it "15 not_voted posts" do
     expect(Post.not_voted_by(user.id).count).to eq(15)
    end

    context "with voted posts" do
      before do
        posts = Post.all
        # 1. 0: no votes
        # 2. 1..2: vote by user
        # 4. 3..6: vote by both
        # 8. 7..14: vote by another_user
        (1..6).each do |n|
          user.vote_for(posts[n])
        end
        (3..14).each do |n|
          another_user.vote_for(posts[n])
        end
      end

      context "user" do
        it "6 voted posts" do
          expect(Post.search(votes_voter_id_in: user.id).result(distinct: true).count).to eq(6)
        end
        pending "9 unvoted posts" do
          expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(9)
        end
        it "9 not_voted posts" do
          expect(Post.not_voted_by(user.id).count).to eq(9)
        end
      end

      context "another_user" do
        it "12 voted posts" do
          expect(Post.search(votes_voter_id_in: another_user.id).result(distinct: true).count).to eq(12)
        end
        pending "3 unvoted posts" do
          expect(Post.search(votes_voter_id_not_in: another_user.id).result(distinct: true).count).to eq(3)
        end
        it "3 not_voted posts" do
          expect(Post.not_voted_by(another_user.id).count).to eq(3)
        end
      end

      context "with joins" do
        #let(:scope) { Post.includes({ :votes => :voter }) }
        #~> ActiveRecord::EagerLoadPolymorphicError:
        #     Can not eagerly load the polymorphic association :voter

        let(:scope) { Post.includes({ :votes => :voter }).joins(:votes) }

        context "user" do
          it "6 voted posts" do
            expect(scope.search(votes_voter_id_in: user.id).result(distinct: true).count).to eq(6)
          end
          pending "9 unvoted posts" do
            expect(scope.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(9)
          end
          it "9 not_voted posts" do
            expect(scope.not_voted_by(user.id).count).to eq(9)
          end
        end

        context "another_user" do
          it "12 voted posts" do
            expect(scope.search(votes_voter_id_in: another_user.id).result(distinct: true).count).to eq(12)
          end
          pending "3 unvoted posts" do
            expect(scope.search(votes_voter_id_not_in: another_user.id).result(distinct: true).count).to eq(3)
          end
          it "3 not_voted posts" do
            expect(scope.not_voted_by(another_user.id).count).to eq(3)
          end
        end
      end
    end
  end
end

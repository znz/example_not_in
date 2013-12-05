# README

This is example app inclules failed specs.

* `not_in` is unexpected behavior

## Failures log

```
Failures:

  1) Post with 2 posts two unvoted posts
     Failure/Error: expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(2)

       expected: 2
            got: 0

       (compared using ==)
     # ./spec/models/post_spec.rb:22:in `block (3 levels) in <top (required)>'

  2) Post with 2 posts with one voted post one unvoted post
     Failure/Error: expect(Post.search(votes_voter_id_not_in: user.id).result(distinct: true).count).to eq(1)

       expected: 1
            got: 0

       (compared using ==)
     # ./spec/models/post_spec.rb:31:in `block (4 levels) in <top (required)>'

Finished in 0.21276 seconds
7 examples, 2 failures

Failed examples:

rspec ./spec/models/post_spec.rb:21 # Post with 2 posts two unvoted posts
rspec ./spec/models/post_spec.rb:30 # Post with 2 posts with one voted post one unvoted post
```

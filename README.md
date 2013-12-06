# README

This is example app inclules failed specs.

* `not_in` is unexpected behavior

## Failures log

```
Failures:

  1) Post with 15 posts with voted posts another_user 3 not_voted posts
     Failure/Error: expect(Post.search(not_voted_by_condition(another_user.id)).result(distinct: true).count).to eq(3)

       expected: 3
            got: 7

       (compared using ==)
     # ./spec/models/post_spec.rb:59:in `block (5 levels) in <top (required)>'

  2) Post with 15 posts with voted posts user 9 not_voted posts
     Failure/Error: expect(Post.search(not_voted_by_condition(user.id)).result(distinct: true).count).to eq(9)

       expected: 9
            got: 13

       (compared using ==)
     # ./spec/models/post_spec.rb:50:in `block (5 levels) in <top (required)>'
```

# README

This is example app inclules failed specs.

* `not_in` is unexpected behavior

## Failures log

```
Failures:

  1) Post with 15 posts with posts voted by both user 0 not_voted posts
     Failure/Error: expect(not_voted_by(user.id).count).to eq(0)

       expected: 0
            got: 15

       (compared using ==)
     # ./spec/models/post_spec.rb:72:in `block (5 levels) in <top (required)>'

  2) Post with 15 posts with posts voted by both another_user no not_voted posts
     Failure/Error: expect(not_voted_by(another_user.id).count).to eq(0)

       expected: 0
            got: 15

       (compared using ==)
     # ./spec/models/post_spec.rb:80:in `block (5 levels) in <top (required)>'
```

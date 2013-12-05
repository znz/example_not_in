# README

This is example app inclules failed specs.

* `not_in` is unexpected behavior

## Failures log

```
Pending:
  Post with 15 posts 15 unvoted posts
    # No reason given
    # ./spec/models/post_spec.rb:22
  Post with 15 posts with voted posts another_user 3 unvoted posts
    # No reason given
    # ./spec/models/post_spec.rb:60
  Post with 15 posts with voted posts user 9 unvoted posts
    # No reason given
    # ./spec/models/post_spec.rb:48
  Post with 15 posts with voted posts with joins user 9 unvoted posts
    # No reason given
    # ./spec/models/post_spec.rb:79
  Post with 15 posts with voted posts with joins another_user 3 unvoted posts
    # No reason given
    # ./spec/models/post_spec.rb:91

Failures:

  1) Post with 15 posts with voted posts with joins user 9 not_voted posts
     Failure/Error: expect(scope.not_voted_by(user.id).count).to eq(9)

       expected: 9
            got: 8

       (compared using ==)
     # ./spec/models/post_spec.rb:83:in `block (6 levels) in <top (required)>'

  2) Post with 15 posts with voted posts with joins another_user 3 not_voted posts
     Failure/Error: expect(scope.not_voted_by(another_user.id).count).to eq(3)

       expected: 3
            got: 2

       (compared using ==)
     # ./spec/models/post_spec.rb:95:in `block (6 levels) in <top (required)>'
```

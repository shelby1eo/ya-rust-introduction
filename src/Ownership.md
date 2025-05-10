# Ownership

<div class="warning">
    This is one of the fondamental concept of Rust!!!
</div>

In order to assure memory safety the following 3 rules are enforced by the compiler:
- Each value in Rust has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

The operators that have an effect on the **ownership** are:
| operator | name | Column3 |
| ---- | ---- | ---- |
| = | Assignment | when move, the ownership is also transfered |
| & | Borrow | ownership is transfered. ownership is returned once new owner goes out of the scope |


# Enum-Option
what are *The Option Enum and Its Advantages Over Null Values*?

Null takes different meaning depending on the contest:
- Non init Variable.
- Absence of value.
- Failure of a function.
- ...

Ref:
- [Qcon London 2009: Tony Hoare, Null References The Billion Dollar Mistake](https://www.youtube.com/watch?v=YYkOWzrO3xg)
- [freecodecamp on Null](https://www.freecodecamp.org/news/a-quick-and-thorough-guide-to-null-what-it-is-and-how-you-should-use-it-d170cea62840/)

Rust do not have Null but it still express the concept of **absence of value** via the standard library std::Option.

Option is implemented as (this Enum makes use of Generic, it will be explained later):

```rust,noplayground
enum Option<T> {
    None,
    Some(T),
}
```

An Option can be either None or of a value of any type.
The type can be inferred, except the case of None, where Rust require you to specify to which type you want to express an absence of value.
```rust,noplayground
let some_number = Some(5);
let some_char = Some('e');

let absent_number: Option<i32> = None;

```

Try to run the following code:
```rust,editable
// expected to fail
fn main() {
    let x: i8 = 5;
    let y: Option<i8> = Some(5);

    let sum = x + y;
}
```

Option is used in order to represent the possibility that a variable do not have a value,
Option<T> is of different type of T, and you would need to convert Option<T> into T before being able to use the variable.
This conversion force you to check the validity of the variable before using it therefore eliminating a common runtime error
**"derefencing an null reference"**.

Option are heavily used make sure to be familiar with its documentation
ref: [std::Option](https://doc.rust-lang.org/std/option/enum.Option.html).



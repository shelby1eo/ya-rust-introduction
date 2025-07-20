# print and trait

Try to execute the following code:
```rust,editable
struct Point {
    x: u32,
    y: u32,
}
fn main() {
    let point = Point {
        x: 0,
        y: 1,
    };
    println!("{}", point);
}
```

Lets analyze the suggestions of the compiler:
```
   = help: the trait `std::fmt::Display` is not implemented for `Point`
   = note: in format strings you may be able to use `{:?}` (or {:#?} for pretty-print) instead
```

What is a trait? It is something similar to a interface for a datatype.

First the compiler tell us that the trait Display is not implemented for the struct,
since there is not a unique way to *display* a struct (space sparated? comma separated? which order?)
it will take the safe choice of generating an error instead of guessing.  
Second it suggest to try to use the Debug trait, lets try it:

```rust,editable
struct Point {
    x: u32,
    y: u32,
}
fn main() {
    let point = Point {
        x: 0,
        y: 1,
    };
    println!("{:?}", point);
}
```

Lets analyze the suggestions of the compiler:
```
   = help: the trait `Debug` is not implemented for `Point`
   = note: add `#[derive(Debug)]` to `Point` or manually `impl Debug for Point`
```

Again it seems that the Debug trait is not implemented but this time it is possible to derive it automatically,
it will display something even if the format is not perfect.

```rust,editable
#[derive(Debug)]
struct Point {
    x: u32,
    y: u32,
}
fn main() {
    let point = Point {
        x: 0,
        y: 1,
    };
    println!("{:?}", point);
}
```

Let's now implement `std::fmt::Display`:

```rust,editable
use std::fmt;

struct Point {
    x: u32,
    y: u32,
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}

fn main() {
    let point = Point {
        x: 0,
        y: 1,
    };
    println!("{}", point);
}
```

For some more details on the difference between print and write [rbe print_display](https://doc.rust-lang.org/rust-by-example/hello/print/print_display.html).
